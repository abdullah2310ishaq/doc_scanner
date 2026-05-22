import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Builds a multi-page PDF from cropped images (optional color filter matrix).
class SmartCropPdfService {
  Future<String> createPdf({
    required List<String> imagePaths,
    List<double>? colorMatrix,
  }) async {
    if (imagePaths.isEmpty) {
      throw Exception('No images to export');
    }

    final bakedPaths = <String>[];
    for (final path in imagePaths) {
      bakedPaths.add(await _bakeFilterIfNeeded(path, colorMatrix));
    }

    final pdf = pw.Document();
    for (final path in bakedPaths) {
      final bytes = await File(path).readAsBytes();
      final pwImage = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pwImage, fit: pw.BoxFit.contain),
            );
          },
        ),
      );
    }

    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final pdfPath = '${tempDir.path}/smartcrop_$timestamp.pdf';
    await File(pdfPath).writeAsBytes(await pdf.save());

    for (var i = 0; i < bakedPaths.length; i++) {
      if (bakedPaths[i] != imagePaths[i]) {
        try {
          await File(bakedPaths[i]).delete();
        } catch (_) {}
      }
    }

    return pdfPath;
  }

  Future<String> _bakeFilterIfNeeded(
    String imagePath,
    List<double>? matrix,
  ) async {
    if (matrix == null || matrix.isEmpty) {
      return imagePath;
    }

    final file = File(imagePath);
    if (!file.existsSync()) {
      throw Exception('Image not found');
    }

    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final uiImage = frame.image;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..colorFilter = ColorFilter.matrix(matrix);
    canvas.drawImage(uiImage, Offset.zero, paint);

    final picture = recorder.endRecording();
    final filteredImage = await picture.toImage(
      uiImage.width,
      uiImage.height,
    );

    final byteData = await filteredImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    if (byteData == null) {
      throw Exception('Failed to encode filtered image');
    }

    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filteredPath = '${tempDir.path}/filtered_$timestamp.png';
    await File(filteredPath).writeAsBytes(byteData.buffer.asUint8List());

    uiImage.dispose();
    filteredImage.dispose();
    picture.dispose();

    return filteredPath;
  }
}
