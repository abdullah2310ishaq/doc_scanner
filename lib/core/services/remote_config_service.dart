import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../constants/remote_config_keys.dart';

abstract final class RemoteConfigService {
  static FirebaseRemoteConfig? _remoteConfig;

  static Future<void> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: kDebugMode
            ? Duration.zero
            : const Duration(hours: 1),
      ),
    );
    await remoteConfig.setDefaults(const {
      RemoteConfigKeys.pdfTranslationKey: '',
      RemoteConfigKeys.askPdfKey: '',
      RemoteConfigKeys.ocrTranslationKey: '',
    });

    try {
      final activated = await remoteConfig.fetchAndActivate();
      if (kDebugMode) {
        debugPrint('[RemoteConfig] fetchAndActivate — activated: $activated');
        _logKeyStatus(
          RemoteConfigKeys.pdfTranslationKey,
          remoteConfig.getString(RemoteConfigKeys.pdfTranslationKey),
        );
        _logKeyStatus(
          RemoteConfigKeys.askPdfKey,
          remoteConfig.getString(RemoteConfigKeys.askPdfKey),
        );
        _logKeyStatus(
          RemoteConfigKeys.ocrTranslationKey,
          remoteConfig.getString(RemoteConfigKeys.ocrTranslationKey),
        );
      }
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[RemoteConfig] fetch failed — $error\n$stack');
      }
    }

    _remoteConfig = remoteConfig;
  }

  static String get pdfTranslationKey =>
      _remoteConfig?.getString(RemoteConfigKeys.pdfTranslationKey) ?? '';

  static String get askPdfKey =>
      _remoteConfig?.getString(RemoteConfigKeys.askPdfKey) ?? '';

  static String get ocrTranslationKey =>
      _remoteConfig?.getString(RemoteConfigKeys.ocrTranslationKey) ?? '';

  static void _logKeyStatus(String name, String value) {
    debugPrint('[RemoteConfig] $name — ${value.isNotEmpty ? 'loaded' : 'empty'}');
  }
}
