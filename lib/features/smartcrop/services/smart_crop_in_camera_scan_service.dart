import '../models/smart_crop_page_model.dart';
import 'smart_crop_crop_service.dart';
import 'smart_crop_edge_detect_service.dart';

/// Crops the shutter photo using live-detected corners (CamScanner-style).
class SmartCropInCameraScanService {
  SmartCropInCameraScanService({SmartCropCropService? cropService})
      : _cropService = cropService ?? SmartCropCropService();

  final SmartCropCropService _cropService;

  Future<String> scanCapturedPhoto({
    required String imagePath,
    required DetectedDocumentCorners corners,
    required bool cornersLocked,
  }) async {
    final page = SmartCropPageModel(
      imagePath: imagePath,
      topLeft: corners.topLeft,
      topRight: corners.topRight,
      bottomRight: corners.bottomRight,
      bottomLeft: corners.bottomLeft,
      cornersLocked: cornersLocked,
      isCameraScanned: true,
    );
    return _cropService.cropPage(page);
  }
}
