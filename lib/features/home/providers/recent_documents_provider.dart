import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/navigation/app_navigator.dart';
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
  bool isLoadingSummary = false;

  /// Reloads home folder counts (PDFs + images).
  Future<void> loadSummary() async {
    isLoadingSummary = true;
    notifyListeners();
    final results = await Future.wait([
      _service.loadPdfs(),
      _service.loadImages(),
    ]);
    pdfFiles = results[0];
    imageFiles = results[1];
    isLoadingSummary = false;
    notifyListeners();
  }

  /// Call after [RecentDocumentsService.registerPdf] / [registerImage] from anywhere.
  static Future<void> refreshGlobal() async {
    final context = appNavigatorKey.currentContext;
    if (context == null) {
      return;
    }
    final provider = context.read<RecentDocumentsProvider>();
    await provider.loadSummary();
  }

  Future<void> registerPdf(String sourcePath, {String? displayName}) async {
    await _service.registerPdf(sourcePath, displayName: displayName);
    await loadSummary();
  }

  Future<void> registerImage(String sourcePath, {String? displayName}) async {
    await _service.registerImage(sourcePath, displayName: displayName);
    await loadSummary();
  }

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
