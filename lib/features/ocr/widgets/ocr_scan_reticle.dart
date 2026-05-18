import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class OcrScanReticle extends StatelessWidget {
  const OcrScanReticle({
    super.key,
    this.size = 260,
    this.cornerLength = 44,
    this.strokeWidth = 4,
    this.cornerRadius = 12,
  });

  final double size;
  final double cornerLength;
  final double strokeWidth;
  final double cornerRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _OcrScanReticlePainter(
        cornerLength: cornerLength,
        strokeWidth: strokeWidth,
        cornerRadius: cornerRadius,
      ),
    );
  }
}

class _OcrScanReticlePainter extends CustomPainter {
  _OcrScanReticlePainter({
    required this.cornerLength,
    required this.strokeWidth,
    required this.cornerRadius,
  });

  final double cornerLength;
  final double strokeWidth;
  final double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.liveCameraReticle
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final width = size.width;
    final height = size.height;

    _drawCorner(canvas, paint, Offset(0, 0), true, true);
    _drawCorner(canvas, paint, Offset(width, 0), false, true);
    _drawCorner(canvas, paint, Offset(0, height), true, false);
    _drawCorner(canvas, paint, Offset(width, height), false, false);
  }

  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Offset corner,
    bool isLeft,
    bool isTop,
  ) {
    final horizontalDirection = isLeft ? 1.0 : -1.0;
    final verticalDirection = isTop ? 1.0 : -1.0;

    final horizontalEnd = Offset(
      corner.dx + horizontalDirection * cornerLength,
      corner.dy,
    );
    final verticalEnd = Offset(
      corner.dx,
      corner.dy + verticalDirection * cornerLength,
    );

    final horizontalStart = Offset(
      corner.dx + horizontalDirection * cornerRadius,
      corner.dy,
    );
    final verticalStart = Offset(
      corner.dx,
      corner.dy + verticalDirection * cornerRadius,
    );

    canvas.drawLine(corner, horizontalStart, paint);
    canvas.drawLine(corner, verticalStart, paint);
    canvas.drawLine(horizontalStart, horizontalEnd, paint);
    canvas.drawLine(verticalStart, verticalEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
