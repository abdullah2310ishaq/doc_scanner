/// Result of copying gallery picks into app storage.
class SmartCropGalleryImportResult {
  const SmartCropGalleryImportResult({
    required this.paths,
    this.failedCount = 0,
    this.unsupportedCount = 0,
  });

  final List<String> paths;
  final int failedCount;
  final int unsupportedCount;

  int get totalSkipped => failedCount + unsupportedCount;
}
