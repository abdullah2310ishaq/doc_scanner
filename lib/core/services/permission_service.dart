import 'dart:io';

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

  Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final storage = await Permission.storage.status;
      if (storage.isGranted) {
        return true;
      }

      final photos = await Permission.photos.status;
      return photos.isGranted;
    }

    if (Platform.isIOS) {
      final photosAddOnly = await Permission.photosAddOnly.status;
      if (photosAddOnly.isGranted) {
        return true;
      }

      final photos = await Permission.photos.status;
      return photos.isGranted;
    }

    return true;
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }

      status = await Permission.photos.request();
      return status.isGranted;
    }

    if (Platform.isIOS) {
      var status = await Permission.photosAddOnly.request();
      if (status.isGranted) {
        return true;
      }

      status = await Permission.photos.request();
      return status.isGranted;
    }

    return true;
  }

  Future<bool> openSettings() => openAppSettings();
}
