import 'package:image/image.dart' as img;

/// Removes empty white margins so only the document content remains.
img.Image trimDocumentMargins(img.Image source, {int whiteThreshold = 248}) {
  final w = source.width;
  final h = source.height;
  if (w < 4 || h < 4) return source;

  bool isContent(int x, int y) {
    final lum = source.getPixel(x, y).luminance;
    return lum < whiteThreshold;
  }

  var top = 0;
  var bottom = h - 1;
  var left = 0;
  var right = w - 1;

  scanTop:
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      if (isContent(x, y)) {
        top = y;
        break scanTop;
      }
    }
  }

  scanBottom:
  for (var y = h - 1; y >= top; y--) {
    for (var x = 0; x < w; x++) {
      if (isContent(x, y)) {
        bottom = y;
        break scanBottom;
      }
    }
  }

  scanLeft:
  for (var x = 0; x < w; x++) {
    for (var y = top; y <= bottom; y++) {
      if (isContent(x, y)) {
        left = x;
        break scanLeft;
      }
    }
  }

  scanRight:
  for (var x = w - 1; x >= left; x--) {
    for (var y = top; y <= bottom; y++) {
      if (isContent(x, y)) {
        right = x;
        break scanRight;
      }
    }
  }

  final cropW = right - left + 1;
  final cropH = bottom - top + 1;
  if (cropW < 2 || cropH < 2) return source;

  return img.copyCrop(source, x: left, y: top, width: cropW, height: cropH);
}
