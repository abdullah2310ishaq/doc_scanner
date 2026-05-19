import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

class PdfAssistantDownloadService {
  Future<File> downloadPdf(String url, String savePath) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !uri.hasScheme) {
      throw StateError('invalid_url');
    }

    final response = await http
        .get(uri)
        .timeout(const Duration(seconds: 60));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError('download_failed');
    }

    final bytes = response.bodyBytes;
    if (bytes.length < 4) {
      throw StateError('invalid_pdf');
    }

    final header = String.fromCharCodes(bytes.take(4));
    if (!header.startsWith('%PDF')) {
      throw StateError('invalid_pdf');
    }

    final file = File(savePath);
    await file.parent.create(recursive: true);
    await file.writeAsBytes(bytes);
    return file;
  }

  String fileNameFromUrl(String url) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null) return 'document.pdf';

    final segment = p.basename(uri.path);
    if (segment.toLowerCase().endsWith('.pdf') && segment.isNotEmpty) {
      return segment;
    }
    return 'document.pdf';
  }
}
