import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/services/permission_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../providers/live_ocr_camera_provider.dart';
import '../widgets/live_ocr_camera_overlay_button.dart';
import '../widgets/live_ocr_camera_shutter.dart';
import '../widgets/live_ocr_camera_tip_banner.dart';
import '../widgets/live_ocr_text_painter.dart';
import '../widgets/ocr_scan_reticle.dart';
import '../ocr_flow.dart';

class LiveOcrCameraScreen extends StatefulWidget {
  const LiveOcrCameraScreen({super.key});

  static Future<void> open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ChangeNotifierProvider(
          create: (_) => LiveOcrCameraProvider()..initialize(),
          child: const LiveOcrCameraScreen(),
        ),
      ),
    );
  }

  @override
  State<LiveOcrCameraScreen> createState() => _LiveOcrCameraScreenState();
}

class _LiveOcrCameraScreenState extends State<LiveOcrCameraScreen>
    with WidgetsBindingObserver {
  bool _permissionDialogRequested = false;

  static const _cameraOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(_cameraOverlayStyle);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    final provider = context.read<LiveOcrCameraProvider>();
    if (state == AppLifecycleState.paused) {
      provider.pauseLiveOcr();
    } else if (state == AppLifecycleState.resumed) {
      provider.resumeLiveOcr();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  Future<void> _onCapture(LiveOcrCameraProvider provider) async {
    final imagePath = await provider.captureImage();
    if (!mounted) return;

    if (imagePath == null) {
      if (provider.status == LiveOcrCameraStatus.error) {
        _showErrorSnackBar(context.l10n.errorOcrFailed);
      }
      return;
    }

    await OcrFlow.analyzeImage(
      context,
      imagePath: imagePath,
      replaceCurrentRoute: true,
    );
  }

  void _handlePermissionDenied() {
    if (_permissionDialogRequested) return;
    _permissionDialogRequested = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _showPermissionDialog();
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _showPermissionDialog() async {
    final l10n = context.l10n;
    final openSettings = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.permissionCameraTitle),
          content: Text(l10n.permissionCameraMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.permissionOpenSettings),
            ),
          ],
        );
      },
    );

    if (openSettings == true) {
      await PermissionService().openSettings();
    }

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.liveCameraBackground,
      body: Consumer<LiveOcrCameraProvider>(
        builder: (context, provider, _) {
          if (provider.status == LiveOcrCameraStatus.permissionDenied) {
            _handlePermissionDenied();
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              _CameraPreviewLayer(provider: provider),
              if (provider.isCapturing)
                const ColoredBox(
                  color: Color(0x99000000),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  ),
                ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _Header(
                        title: l10n.ocrLiveCameraTitle,
                        closeLabel: l10n.ocrLiveCameraClose,
                        flashLabel: l10n.ocrLiveCameraFlash,
                        isFlashOn: provider.isFlashOn,
                        isFlashEnabled:
                            provider.status == LiveOcrCameraStatus.ready,
                        onClose: () => Navigator.of(context).pop(),
                        onFlashToggle: provider.toggleFlash,
                      ),
                      const Spacer(),
                      const OcrScanReticle(),
                      const Spacer(),
                      LiveOcrCameraShutter(
                        semanticsLabel: l10n.ocrLiveCameraCapture,
                        isEnabled: provider.status == LiveOcrCameraStatus.ready,
                        onTap: () => _onCapture(provider),
                      ),
                      const SizedBox(height: 20),
                      LiveOcrCameraTipBanner(message: l10n.ocrLiveCameraTip),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              if (provider.status == LiveOcrCameraStatus.initializing)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.liveCameraText,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.ocrLiveCameraInitializing,
                        style: const TextStyle(color: AppColors.liveCameraText),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CameraPreviewLayer extends StatelessWidget {
  const _CameraPreviewLayer({required this.provider});

  final LiveOcrCameraProvider provider;

  @override
  Widget build(BuildContext context) {
    final controller = provider.cameraController;

    if (controller == null || !controller.value.isInitialized) {
      return const ColoredBox(color: AppColors.liveCameraBackground);
    }

    return ColoredBox(
      color: AppColors.liveCameraBackground,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final previewSize = controller.value.previewSize;
          if (previewSize == null) {
            return CameraPreview(controller);
          }

          final previewWidth = previewSize.height;
          final previewHeight = previewSize.width;

          return ClipRect(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: previewWidth,
                height: previewHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CameraPreview(controller),
                    CustomPaint(
                      painter: LiveOcrTextPainter(
                        blocks: provider.detectedBlocks,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.closeLabel,
    required this.flashLabel,
    required this.isFlashOn,
    required this.isFlashEnabled,
    required this.onClose,
    required this.onFlashToggle,
  });

  final String title;
  final String closeLabel;
  final String flashLabel;
  final bool isFlashOn;
  final bool isFlashEnabled;
  final VoidCallback onClose;
  final VoidCallback onFlashToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          LiveOcrCameraOverlayButton(
            icon: Icons.close,
            semanticsLabel: closeLabel,
            onTap: onClose,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.liveCameraText,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Opacity(
            opacity: isFlashEnabled ? 1 : 0.4,
            child: LiveOcrCameraOverlayButton(
              icon: isFlashOn ? Icons.flash_on : Icons.flash_off_outlined,
              semanticsLabel: flashLabel,
              onTap: isFlashEnabled ? onFlashToggle : () {},
            ),
          ),
        ],
      ),
    );
  }
}
