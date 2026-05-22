import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// L-shaped corners + quad lines (black → green when document detected).
class SmartCropDocumentReticle extends StatelessWidget {
  const SmartCropDocumentReticle({
    super.key,
    required this.previewRect,
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
    required this.isDetected,
    this.cornerLength = 40,
    this.strokeWidth = 4,
  });

  final Rect previewRect;
  final Offset topLeft;
  final Offset topRight;
  final Offset bottomRight;
  final Offset bottomLeft;
  final bool isDetected;
  final double cornerLength;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final color = isDetected
        ? AppColors.smartCropReticleDetected
        : AppColors.smartCropReticleIdle;

    final screenCorners = [
      _normToScreen(topLeft),
      _normToScreen(topRight),
      _normToScreen(bottomRight),
      _normToScreen(bottomLeft),
    ];

    return CustomPaint(
      painter: _DocumentReticlePainter(
        corners: screenCorners,
        color: color,
        cornerLength: cornerLength,
        strokeWidth: strokeWidth,
        drawQuad: isDetected,
      ),
      child: const SizedBox.expand(),
    );
  }

  Offset _normToScreen(Offset norm) {
    return Offset(
      previewRect.left + norm.dx.clamp(0, 1) * previewRect.width,
      previewRect.top + norm.dy.clamp(0, 1) * previewRect.height,
    );
  }
}

class _DocumentReticlePainter extends CustomPainter {
  _DocumentReticlePainter({
    required this.corners,
    required this.color,
    required this.cornerLength,
    required this.strokeWidth,
    required this.drawQuad,
  });

  final List<Offset> corners;
  final Color color;
  final double cornerLength;
  final double strokeWidth;
  final bool drawQuad;

  @override
  void paint(Canvas canvas, Size size) {
    if (corners.length != 4) return;

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (drawQuad) {
      final path = Path()
        ..moveTo(corners[0].dx, corners[0].dy)
        ..lineTo(corners[1].dx, corners[1].dy)
        ..lineTo(corners[2].dx, corners[2].dy)
        ..lineTo(corners[3].dx, corners[3].dy)
        ..close();
      canvas.drawPath(path, linePaint);
    }

    for (var i = 0; i < 4; i++) {
      final isLeft = i == 0 || i == 3;
      final isTop = i == 0 || i == 1;
      _drawCorner(canvas, linePaint, corners[i], isLeft, isTop);
    }
  }

  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    bool isLeft,
    bool isTop,
  ) {
    final hDir = isLeft ? 1.0 : -1.0;
    final vDir = isTop ? 1.0 : -1.0;
    final hEnd = Offset(corner.dx + hDir * cornerLength, corner.dy);
    final vEnd = Offset(corner.dx, corner.dy + vDir * cornerLength);
    canvas.drawLine(corner, hEnd, paint);
    canvas.drawLine(corner, vEnd, paint);
  }

  @override
  bool shouldRepaint(covariant _DocumentReticlePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawQuad != drawQuad ||
        oldDelegate.corners != corners;
  }
}

/// Maps normalized corners to the visible preview rect (BoxFit.cover).
Rect smartCropPreviewContentRect(Size boxSize, Size previewSize) {
  final imageAspect = previewSize.width / previewSize.height;
  final boxAspect = boxSize.width / boxSize.height;
  double w;
  double h;
  if (imageAspect > boxAspect) {
    h = boxSize.height;
    w = h * imageAspect;
  } else {
    w = boxSize.width;
    h = w / imageAspect;
  }
  final left = (boxSize.width - w) / 2;
  final top = (boxSize.height - h) / 2;
  return Rect.fromLTWH(left, top, w, h);
}
