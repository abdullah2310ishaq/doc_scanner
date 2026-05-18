import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Future<Size> readImageSize(String imagePath) async {
  final bytes = await File(imagePath).readAsBytes();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  final image = frame.image;
  return Size(image.width.toDouble(), image.height.toDouble());
}
