import 'dart:io';

import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Hardware-aware tuning for camera preview and live OCR cadence.
class DevicePerformanceProfile {
  DevicePerformanceProfile._({
    required this.previewPreset,
    required this.ocrDetectIntervalMs,
  });

  static DevicePerformanceProfile? _cached;

  final ResolutionPreset previewPreset;
  final int ocrDetectIntervalMs;

  static Future<DevicePerformanceProfile> load() async {
    if (_cached != null) return _cached!;

    var preset = ResolutionPreset.medium;
    var intervalMs = 350;

    try {
      final plugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final info = await plugin.androidInfo;
        final ramGb = info.physicalRamSize / 1024;
        if (ramGb <= 4) {
          preset = ResolutionPreset.medium;
          intervalMs = 600;
        } else {
          preset = ResolutionPreset.high;
          intervalMs = 250;
        }
      } else if (Platform.isIOS) {
        preset = ResolutionPreset.high;
        intervalMs = 250;
      }
    } catch (_) {
      preset = ResolutionPreset.medium;
      intervalMs = 350;
    }

    _cached = DevicePerformanceProfile._(
      previewPreset: preset,
      ocrDetectIntervalMs: intervalMs,
    );
    return _cached!;
  }
}
