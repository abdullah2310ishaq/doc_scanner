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
      RemoteConfigKeys.apiModal: 'gpt-5.4-mini',
      RemoteConfigKeys.splashInterAd: false,
      RemoteConfigKeys.splashAppOpenAd: false,
      RemoteConfigKeys.recentPdfBannerAd: false,
      RemoteConfigKeys.recentPdfNativeAd: false,
      RemoteConfigKeys.ocrProcessingNativeAd: false,
      RemoteConfigKeys.pdfProcessingNativeAd: false,
      RemoteConfigKeys.backInterAd: false,
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
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.apiModal} — '
          '${remoteConfig.getString(RemoteConfigKeys.apiModal)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.splashInterAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.splashInterAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.splashAppOpenAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.splashAppOpenAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.recentPdfBannerAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.recentPdfBannerAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.recentPdfNativeAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.recentPdfNativeAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.ocrProcessingNativeAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.ocrProcessingNativeAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.pdfProcessingNativeAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.pdfProcessingNativeAd)}',
        );
        debugPrint(
          '[RemoteConfig] ${RemoteConfigKeys.backInterAd} — '
          '${remoteConfig.getBool(RemoteConfigKeys.backInterAd)}',
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

  static String get apiModal =>
      _remoteConfig?.getString(RemoteConfigKeys.apiModal) ?? '';

  static bool get splashInterAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.splashInterAd) ?? false;

  static bool get splashAppOpenAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.splashAppOpenAd) ?? false;

  static bool get recentPdfBannerAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.recentPdfBannerAd) ?? false;

  static bool get recentPdfNativeAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.recentPdfNativeAd) ?? false;

  static bool get ocrProcessingNativeAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.ocrProcessingNativeAd) ?? false;

  static bool get pdfProcessingNativeAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.pdfProcessingNativeAd) ?? false;

  static bool get backInterAd =>
      _remoteConfig?.getBool(RemoteConfigKeys.backInterAd) ?? false;

  static void _logKeyStatus(String name, String value) {
    debugPrint('[RemoteConfig] $name — ${value.isNotEmpty ? 'loaded' : 'empty'}');
  }
}
