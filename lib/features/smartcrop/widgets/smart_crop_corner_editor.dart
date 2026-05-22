import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// Draggable 4-corner overlay for perspective crop (CamScanner-style).
class SmartCropCornerEditor extends StatefulWidget {
  const SmartCropCornerEditor({
    super.key,
    required this.imagePath,
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
    required this.onCornersChanged,
    this.onSwipeToPrevious,
    this.onSwipeToNext,
  });

  final String imagePath;
  final Offset topLeft;
  final Offset topRight;
  final Offset bottomRight;
  final Offset bottomLeft;
  final void Function({
    required Offset topLeft,
    required Offset topRight,
    required Offset bottomRight,
    required Offset bottomLeft,
  }) onCornersChanged;
  final VoidCallback? onSwipeToPrevious;
  final VoidCallback? onSwipeToNext;

  static const Color frameColor = AppColors.smartCropPrimary;

  @override
  State<SmartCropCornerEditor> createState() => _SmartCropCornerEditorState();
}

class _SmartCropCornerEditorState extends State<SmartCropCornerEditor> {
  late Offset _tl;
  late Offset _tr;
  late Offset _br;
  late Offset _bl;
  int? _dragIndex;
  double _swipeDx = 0;

  ui.Image? _decodedImage;

  static const _swipeThreshold = 48.0;

  @override
  void initState() {
    super.initState();
    _tl = widget.topLeft;
    _tr = widget.topRight;
    _br = widget.bottomRight;
    _bl = widget.bottomLeft;
    _loadImage();
  }

  @override
  void didUpdateWidget(SmartCropCornerEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _loadImage();
    }
    if (oldWidget.topLeft != widget.topLeft ||
        oldWidget.topRight != widget.topRight ||
        oldWidget.bottomRight != widget.bottomRight ||
        oldWidget.bottomLeft != widget.bottomLeft) {
      _tl = widget.topLeft;
      _tr = widget.topRight;
      _br = widget.bottomRight;
      _bl = widget.bottomLeft;
    }
  }

  Future<void> _loadImage() async {
    final bytes = await File(widget.imagePath).readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    if (!mounted) return;
    setState(() => _decodedImage = frame.image);
  }

  void _notify() {
    widget.onCornersChanged(
      topLeft: _tl,
      topRight: _tr,
      bottomRight: _br,
      bottomLeft: _bl,
    );
  }

  List<Offset> get _normCorners => [_tl, _tr, _br, _bl];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final imageRect = _imageRect(size);

        return GestureDetector(
          onPanStart: (d) {
            _swipeDx = 0;
            _dragIndex = _hitCorner(d.localPosition, imageRect);
          },
          onPanUpdate: (d) {
            if (_dragIndex != null) {
              final norm = _screenToNorm(d.localPosition, imageRect);
              setState(() {
                switch (_dragIndex) {
                  case 0:
                    _tl = norm;
                  case 1:
                    _tr = norm;
                  case 2:
                    _br = norm;
                  case 3:
                    _bl = norm;
                }
              });
              _notify();
              return;
            }
            _swipeDx += d.delta.dx;
          },
          onPanEnd: (_) {
            if (_dragIndex == null) {
              if (_swipeDx >= _swipeThreshold) {
                widget.onSwipeToPrevious?.call();
              } else if (_swipeDx <= -_swipeThreshold) {
                widget.onSwipeToNext?.call();
              }
            }
            _dragIndex = null;
            _swipeDx = 0;
          },
          child: CustomPaint(
            size: size,
            painter: _CornerFramePainter(
              image: _decodedImage,
              imageRect: imageRect,
              screenCorners: _normCorners
                  .map((n) => _normToScreen(n, imageRect))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Rect _imageRect(Size size) {
    final image = _decodedImage;
    if (image == null) {
      return Rect.fromLTWH(0, 0, size.width, size.height);
    }
    final imageAspect = image.width / image.height;
    final boxAspect = size.width / size.height;
    double w;
    double h;
    if (imageAspect > boxAspect) {
      w = size.width;
      h = w / imageAspect;
    } else {
      h = size.height;
      w = h * imageAspect;
    }
    final left = (size.width - w) / 2;
    final top = (size.height - h) / 2;
    return Rect.fromLTWH(left, top, w, h);
  }

  Offset _normToScreen(Offset norm, Rect rect) {
    return Offset(
      rect.left + norm.dx.clamp(0, 1) * rect.width,
      rect.top + norm.dy.clamp(0, 1) * rect.height,
    );
  }

  Offset _screenToNorm(Offset screen, Rect rect) {
    if (rect.width <= 0 || rect.height <= 0) return Offset.zero;
    return Offset(
      ((screen.dx - rect.left) / rect.width).clamp(0.02, 0.98),
      ((screen.dy - rect.top) / rect.height).clamp(0.02, 0.98),
    );
  }

  int? _hitCorner(Offset screen, Rect rect) {
    const hitRadius = 28.0;
    final points = _normCorners.map((n) => _normToScreen(n, rect)).toList();
    for (var i = 0; i < points.length; i++) {
      if ((points[i] - screen).distance <= hitRadius) return i;
    }
    return null;
  }
}

class _CornerFramePainter extends CustomPainter {
  _CornerFramePainter({
    required this.image,
    required this.imageRect,
    required this.screenCorners,
  });

  final ui.Image? image;
  final Rect imageRect;
  final List<Offset> screenCorners;

  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      paintImage(
        canvas: canvas,
        rect: imageRect,
        image: image!,
        fit: BoxFit.fill,
      );
    }

    if (screenCorners.length != 4) return;

    final linePaint = Paint()
      ..color = SmartCropCornerEditor.frameColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(screenCorners[0].dx, screenCorners[0].dy)
      ..lineTo(screenCorners[1].dx, screenCorners[1].dy)
      ..lineTo(screenCorners[2].dx, screenCorners[2].dy)
      ..lineTo(screenCorners[3].dx, screenCorners[3].dy)
      ..close();
    canvas.drawPath(path, linePaint);

    for (final point in screenCorners) {
      canvas.drawCircle(
        point,
        12,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        point,
        10,
        Paint()..color = SmartCropCornerEditor.frameColor,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CornerFramePainter oldDelegate) => true;
}
