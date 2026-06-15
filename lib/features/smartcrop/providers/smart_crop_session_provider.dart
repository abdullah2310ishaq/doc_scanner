import 'package:flutter/foundation.dart';

import '../../../core/constants/smart_crop_limits.dart';
import '../models/smart_crop_page_model.dart';

/// How the user started adding images in this session.
enum SmartCropSessionSource {
  gallery,
  camera,
}

/// Holds all captures in one smart-crop session (ML Kit on Android).
class SmartCropSessionProvider extends ChangeNotifier {
  final List<SmartCropPageModel> _pages = [];

  SmartCropSessionSource source = SmartCropSessionSource.camera;

  int? _pendingCornerDetectIndex;

  /// Index that needs edge pre-detect after add/replace; consumed by captured screen.
  int? consumePendingCornerDetectIndex() {
    final index = _pendingCornerDetectIndex;
    _pendingCornerDetectIndex = null;
    return index;
  }

  List<SmartCropPageModel> get pages => List.unmodifiable(_pages);
  int get pageCount => _pages.length;
  bool get isEmpty => _pages.isEmpty;
  bool get canAddMore => _pages.length < SmartCropLimits.maxPages;

  void setFromPaths(
    List<String> paths, {
    bool isMlKitProcessed = false,
    bool isCameraScanned = false,
  }) {
    _pages
      ..clear()
      ..addAll(
        paths.take(SmartCropLimits.maxPages).map(
          (path) => SmartCropPageModel(
            imagePath: path,
            isMlKitProcessed: isMlKitProcessed,
            isCameraScanned: isCameraScanned,
          ),
        ),
      );
    notifyListeners();
  }

  void addPage(
    String imagePath, {
    bool isMlKitProcessed = false,
    bool isCameraScanned = false,
  }) {
    if (!canAddMore) return;
    _pages.add(
      SmartCropPageModel(
        imagePath: imagePath,
        isMlKitProcessed: isMlKitProcessed,
        isCameraScanned: isCameraScanned,
      ),
    );
    _pendingCornerDetectIndex = _pages.length - 1;
    notifyListeners();
  }

  void replacePage(int index, String imagePath) {
    if (index < 0 || index >= _pages.length) return;
    _pages[index] = SmartCropPageModel(imagePath: imagePath);
    _pendingCornerDetectIndex = index;
    notifyListeners();
  }

  bool get allPagesAlreadyScanned =>
      _pages.isNotEmpty && _pages.every((p) => p.isAlreadyScanned);

  bool get anyPageNeedsCornerReview => _pages.any(
        (p) => !p.isAlreadyScanned && !p.cornersLocked,
      );

  void updatePage(int index, SmartCropPageModel page) {
    if (index < 0 || index >= _pages.length) return;
    _pages[index] = page;
    notifyListeners();
  }

  void lockAllCorners() {
    for (var i = 0; i < _pages.length; i++) {
      _pages[i] = _pages[i].copyWith(cornersLocked: true);
    }
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _pages.length) return;
    _pages.removeAt(index);
    notifyListeners();
  }

  int get lastIndex => _pages.isEmpty ? -1 : _pages.length - 1;
}
