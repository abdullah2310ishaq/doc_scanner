import 'dart:math' as math;

import 'package:image/image.dart' as img;

/// Perspective-correct crop using four document corners (normalized 0–1).
img.Image warpDocument(
  img.Image source, {
  required double tlX,
  required double tlY,
  required double trX,
  required double trY,
  required double brX,
  required double brY,
  required double blX,
  required double blY,
}) {
  final w = source.width;
  final h = source.height;

  final srcX = [tlX * w, trX * w, brX * w, blX * w];
  final srcY = [tlY * h, trY * h, brY * h, blY * h];

  final topW = _dist(srcX[0], srcY[0], srcX[1], srcY[1]);
  final bottomW = _dist(srcX[3], srcY[3], srcX[2], srcY[2]);
  final leftH = _dist(srcX[0], srcY[0], srcX[3], srcY[3]);
  final rightH = _dist(srcX[1], srcY[1], srcX[2], srcY[2]);

  final outW = math.max(1, ((topW + bottomW) / 2).round());
  final outH = math.max(1, ((leftH + rightH) / 2).round());

  final matrix = _homographyDstToSrc(
    dstWidth: outW.toDouble(),
    dstHeight: outH.toDouble(),
    srcX: srcX,
    srcY: srcY,
  );

  final out = img.Image(width: outW, height: outH);
  for (var y = 0; y < outH; y++) {
    for (var x = 0; x < outW; x++) {
      final src = _applyHomography(matrix, x.toDouble(), y.toDouble());
      final pixel = _sampleBilinear(source, src.x, src.y);
      out.setPixel(x, y, pixel);
    }
  }
  return out;
}

double _dist(double x1, double y1, double x2, double y2) {
  return math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

List<double> _homographyDstToSrc({
  required double dstWidth,
  required double dstHeight,
  required List<double> srcX,
  required List<double> srcY,
}) {
  final dstX = [0.0, dstWidth, dstWidth, 0.0];
  final dstY = [0.0, 0.0, dstHeight, dstHeight];

  final a = List<List<double>>.generate(8, (_) => List.filled(8, 0));
  final b = List<double>.filled(8, 0);

  for (var i = 0; i < 4; i++) {
    final sx = srcX[i];
    final sy = srcY[i];
    final dx = dstX[i];
    final dy = dstY[i];
    final r1 = i * 2;
    final r2 = i * 2 + 1;
    a[r1][0] = dx;
    a[r1][1] = dy;
    a[r1][2] = 1;
    a[r1][6] = -sx * dx;
    a[r1][7] = -sx * dy;
    b[r1] = sx;
    a[r2][3] = dx;
    a[r2][4] = dy;
    a[r2][5] = 1;
    a[r2][6] = -sy * dx;
    a[r2][7] = -sy * dy;
    b[r2] = sy;
  }

  final h = _solveLinear8(a, b);
  return [...h, 1.0];
}

List<double> _solveLinear8(List<List<double>> a, List<double> b) {
  final n = 8;
  final m = List<List<double>>.generate(
    n,
    (i) => [...a[i], b[i]],
  );

  for (var col = 0; col < n; col++) {
    var pivot = col;
    for (var row = col + 1; row < n; row++) {
      if (m[row][col].abs() > m[pivot][col].abs()) pivot = row;
    }
    final tmp = m[col];
    m[col] = m[pivot];
    m[pivot] = tmp;

    final div = m[col][col];
    if (div.abs() < 1e-9) continue;
    for (var j = col; j <= n; j++) {
      m[col][j] /= div;
    }
    for (var row = 0; row < n; row++) {
      if (row == col) continue;
      final factor = m[row][col];
      for (var j = col; j <= n; j++) {
        m[row][j] -= factor * m[col][j];
      }
    }
  }

  return List<double>.generate(n, (i) => m[i][n]);
}

math.Point<double> _applyHomography(List<double> h, double x, double y) {
  final denom = h[6] * x + h[7] * y + h[8];
  final safe = denom.abs() < 1e-9 ? 1e-9 : denom;
  final sx = (h[0] * x + h[1] * y + h[2]) / safe;
  final sy = (h[3] * x + h[4] * y + h[5]) / safe;
  return math.Point(sx, sy);
}

img.Color _sampleBilinear(img.Image src, double x, double y) {
  if (x < 0 || y < 0 || x >= src.width - 1 || y >= src.height - 1) {
    return img.ColorRgb8(255, 255, 255);
  }
  final x0 = x.floor();
  final y0 = y.floor();
  final x1 = x0 + 1;
  final y1 = y0 + 1;
  final tx = x - x0;
  final ty = y - y0;

  final c00 = src.getPixel(x0, y0);
  final c10 = src.getPixel(x1, y0);
  final c01 = src.getPixel(x0, y1);
  final c11 = src.getPixel(x1, y1);

  int ch(num Function(img.Pixel) get) {
    return (get(c00) * (1 - tx) * (1 - ty) +
            get(c10) * tx * (1 - ty) +
            get(c01) * (1 - tx) * ty +
            get(c11) * tx * ty)
        .round()
        .clamp(0, 255);
  }

  return img.ColorRgb8(
    ch((p) => p.r),
    ch((p) => p.g),
    ch((p) => p.b),
  );
}
