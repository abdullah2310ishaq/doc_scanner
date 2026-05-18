import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> hasCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> openSettings() => openAppSettings();
}
