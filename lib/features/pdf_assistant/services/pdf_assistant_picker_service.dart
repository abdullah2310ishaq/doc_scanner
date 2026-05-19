import 'dart:io';

import 'package:file_picker/file_picker.dart';

class PdfAssistantPickerService {
  Future<File?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );

    if (result == null || result.files.isEmpty) return null;

    final path = result.files.single.path;
    if (path == null) return null;

    return File(path);
  }
}
