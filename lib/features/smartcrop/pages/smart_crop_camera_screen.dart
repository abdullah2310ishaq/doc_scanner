import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../core/services/permission_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../ocr/widgets/live_ocr_camera_overlay_button.dart';
import '../../ocr/widgets/live_ocr_camera_shutter.dart';
import '../../ocr/widgets/live_ocr_camera_tip_banner.dart';
import '../providers/smart_crop_camera_provider.dart';
import '../providers/smart_crop_session_provider.dart';
import '../services/smart_crop_in_camera_scan_service.dart';
import '../smart_crop_flow.dart';
import '../widgets/smart_crop_document_reticle.dart';
import 'smart_crop_captured_screen.dart';

/// Live camera — corner brackets turn green when document edges are detected.
class SmartCropCameraScreen extends StatefulWidget {
  const SmartCropCameraScreen({
    super.key,
    this.isFirstCapture = true,
  });

  final bool isFirstCapture;

  static Future<void> open(
    BuildContext context, {
    required SmartCropSessionProvider session,
    bool isFirstCapture = false,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => SmartCropFlow.wrapSession(
          session: session,
          child: ChangeNotifierProvider(
            create: (_) => SmartCropCameraProvider()..initialize(),
            child: SmartCropCameraScreen(isFirstCapture: isFirstCapture),
          ),
        ),
      ),
    );
  }

  @override
  State<SmartCropCameraScreen> createState() => _SmartCropCameraScreenState();
}

class _SmartCropCameraScreenState extends State<SmartCropCameraScreen> {
  final _inCameraScan = SmartCropInCameraScanService();
  bool _permissionDialogRequested = false;
  bool _isProcessingCapture = false;

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
    SystemChrome.setSystemUIOverlayStyle(_cameraOverlayStyle);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _onCapture(SmartCropCameraProvider camera) async {
    if (_isProcessingCapture) return;

    final session = context.read<SmartCropSessionProvider>();
    final rawPath = await camera.captureImage();
    if (!mounted || rawPath == null) return;

    setState(() => _isProcessingCapture = true);

    try {
      final croppedPath = await _inCameraScan.scanCapturedPhoto(
        imagePath: rawPath,
        corners: camera.corners,
        cornersLocked: camera.documentDetected,
      );
      if (!mounted) return;

      if (widget.isFirstCapture) {
        session.setFromPaths([croppedPath], isCameraScanned: true);
        if (!mounted) return;
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => SmartCropFlow.wrapSession(
              session: session,
              child: const SmartCropCapturedScreen(),
            ),
          ),
        );
      } else {
        session.addPage(croppedPath, isCameraScanned: true);
        if (mounted) Navigator.of(context).pop();
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.commonError)),
      );
    } finally {
      if (mounted) setState(() => _isProcessingCapture = false);
    }
  }

  void _handlePermissionDenied() {
    if (_permissionDialogRequested) return;
    _permissionDialogRequested = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _showPermissionDialog();
    });
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
      body: Consumer<SmartCropCameraProvider>(
        builder: (context, camera, _) {
          if (camera.status == SmartCropCameraStatus.permissionDenied) {
            _handlePermissionDenied();
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              _CameraPreviewWithReticle(camera: camera),
              if (camera.isCapturing || _isProcessingCapture)
                ColoredBox(
                  color: const Color(0x99000000),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                        if (_isProcessingCapture) ...[
                          const SizedBox(height: 16),
                          Text(
                            context.l10n.smartCropProcessingCrop,
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _Header(
                        title: l10n.smartCropLiveCameraTitle,
                        closeLabel: l10n.smartCropLiveCameraClose,
                        flashLabel: l10n.smartCropLiveCameraFlash,
                        isFlashOn: camera.isFlashOn,
                        isFlashEnabled:
                            camera.status == SmartCropCameraStatus.ready,
                        onClose: () => Navigator.of(context).pop(),
                        onFlashToggle: camera.toggleFlash,
                      ),
                      const Spacer(),
                      const SizedBox(height: 120),
                      const Spacer(),
                      LiveOcrCameraShutter(
                        semanticsLabel: l10n.smartCropLiveCameraCapture,
                        isEnabled:
                            camera.status == SmartCropCameraStatus.ready &&
                            !_isProcessingCapture,
                        onTap: () => _onCapture(camera),
                      ),
                      const SizedBox(height: 20),
                      LiveOcrCameraTipBanner(
                        message: camera.documentDetected
                            ? l10n.smartCropLiveCameraTip
                            : l10n.smartCropLiveCameraAlignTip,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              if (camera.status == SmartCropCameraStatus.initializing)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.liveCameraText,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.smartCropLiveCameraInitializing,
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

class _CameraPreviewWithReticle extends StatelessWidget {
  const _CameraPreviewWithReticle({required this.camera});

  final SmartCropCameraProvider camera;

  @override
  Widget build(BuildContext context) {
    final controller = camera.cameraController;

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
          final boxSize = Size(constraints.maxWidth, constraints.maxHeight);
          final contentRect = smartCropPreviewContentRect(
            boxSize,
            Size(previewWidth, previewHeight),
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              ClipRect(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: previewWidth,
                    height: previewHeight,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
              SmartCropDocumentReticle(
                previewRect: contentRect,
                topLeft: camera.corners.topLeft,
                topRight: camera.corners.topRight,
                bottomRight: camera.corners.bottomRight,
                bottomLeft: camera.corners.bottomLeft,
                isDetected: camera.documentDetected,
                cornerLength: 44,
                strokeWidth: 5,
              ),
            ],
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
