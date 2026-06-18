import 'dart:io';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../translate/services/translate_export_storage.dart';

class PdfAssistantFileActionsService {
  Future<void> shareFile(String path, {String? subject}) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(path)], subject: subject),
    );
  }

  Future<void> copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<String> saveToDownloads(String path, String fileName) async {
    final bytes = await File(path).readAsBytes();
    return TranslateExportStorage.saveBytes(bytes: bytes, fileName: fileName);
  }
}
