import 'dart:io';

import 'package:media_store_plus/media_store_plus.dart';
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

  Future<bool> needsStoragePermission() async {
    if (!Platform.isAndroid) {
      return false;
    }

    final sdk = await MediaStore().getPlatformSDKInt();
    return sdk <= 29;
  }

  Future<bool> hasStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    if (!await needsStoragePermission()) {
      return true;
    }

    final storage = await Permission.storage.status;
    return storage.isGranted;
  }

  Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    if (!await needsStoragePermission()) {
      return true;
    }

    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<bool> openSettings() => openAppSettings();
}
