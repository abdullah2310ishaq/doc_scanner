import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

import '../models/recent_file_model.dart';
import '../services/recent_documents_service.dart';

/// Recent PDFs / images list state (load, favorite, delete, share).
class RecentDocumentsProvider extends ChangeNotifier {
  RecentDocumentsProvider({RecentDocumentsService? service})
      : _service = service ?? RecentDocumentsService();

  final RecentDocumentsService _service;

  List<RecentFileModel> pdfFiles = [];
  List<RecentFileModel> imageFiles = [];
  bool isLoadingPdfs = false;
  bool isLoadingImages = false;

  Future<void> loadPdfs() async {
    isLoadingPdfs = true;
    notifyListeners();
    pdfFiles = await _service.loadPdfs();
    isLoadingPdfs = false;
    notifyListeners();
  }

  Future<void> loadImages() async {
    isLoadingImages = true;
    notifyListeners();
    imageFiles = await _service.loadImages();
    isLoadingImages = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(RecentFileModel file) async {
    final next = !file.isFavorite;
    await _service.setFavorite(file, next);
    _updateFileInLists(file.copyWith(isFavorite: next));
  }

  Future<void> deleteFile(RecentFileModel file) async {
    await _service.deleteFile(file);
    pdfFiles.removeWhere((f) => f.id == file.id);
    imageFiles.removeWhere((f) => f.id == file.id);
    notifyListeners();
  }

  Future<void> shareFile(RecentFileModel file) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        subject: file.fileName,
      ),
    );
  }

  void _updateFileInLists(RecentFileModel updated) {
    for (var i = 0; i < pdfFiles.length; i++) {
      if (pdfFiles[i].id == updated.id) {
        pdfFiles[i] = updated;
      }
    }
    for (var i = 0; i < imageFiles.length; i++) {
      if (imageFiles[i].id == updated.id) {
        imageFiles[i] = updated;
      }
    }
    notifyListeners();
  }
}
