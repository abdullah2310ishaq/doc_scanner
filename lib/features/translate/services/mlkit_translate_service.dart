import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart' as mlkit;

import '../models/translate_language.dart';
import '../utils/mlkit_language_mapper.dart';
import 'translate_service.dart';

class MlKitTranslateService implements TranslateService {
  MlKitTranslateService({this.defaultSourceLanguageCode = 'en'});

  final String defaultSourceLanguageCode;
  final mlkit.OnDeviceTranslatorModelManager _modelManager =
      mlkit.OnDeviceTranslatorModelManager();

  mlkit.OnDeviceTranslator? _translator;
  mlkit.TranslateLanguage? _cachedSource;
  mlkit.TranslateLanguage? _cachedTarget;

  @override
  Future<String> translate({
    required String text,
    required TranslateLanguage targetLanguage,
    String? sourceLanguageCode,
  }) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      _log('Skipped — empty text');
      return '';
    }

    final sourceCode = sourceLanguageCode ?? defaultSourceLanguageCode;
    final source = MlKitLanguageMapper.toMlKit(sourceCode);
    final target = MlKitLanguageMapper.toMlKit(targetLanguage.code);

    _log(
      'Request — ${source?.bcpCode ?? sourceCode} → '
      '${target?.bcpCode ?? targetLanguage.code} (${targetLanguage.name}), '
      'chars: ${trimmed.length}',
    );

    if (source == null || target == null) {
      _log(
        'Unsupported — source: $sourceCode, target: ${targetLanguage.code}',
      );
      throw const TranslateException(TranslateFailure.unsupportedLanguage);
    }

    if (source == target) {
      _log('Source and target are the same — returning original text');
      return trimmed;
    }

    await _ensureModelsDownloaded(source, target);
    await _ensureTranslator(source, target);

    try {
      final startedAt = DateTime.now();
      final result = await _translator!.translateText(trimmed);
      final ms = DateTime.now().difference(startedAt).inMilliseconds;
      _log('ML Kit done in ${ms}ms — preview: ${_preview(result)}');
      return result;
    } catch (error, stack) {
      _log('ML Kit error — $error\n$stack');
      throw const TranslateException(TranslateFailure.translationFailed);
    }
  }

  Future<void> _ensureModelsDownloaded(
    mlkit.TranslateLanguage source,
    mlkit.TranslateLanguage target,
  ) async {
    for (final language in [source, target]) {
      final bcpCode = language.bcpCode;
      final isDownloaded = await _modelManager.isModelDownloaded(bcpCode);
      if (isDownloaded) {
        _log('Model already downloaded — $bcpCode');
        continue;
      }

      _log('Downloading model — $bcpCode');
      try {
        final startedAt = DateTime.now();
        final downloaded = await _modelManager.downloadModel(
          bcpCode,
          isWifiRequired: false,
        );
        final ms = DateTime.now().difference(startedAt).inMilliseconds;
        if (!downloaded) {
          _log('Model download failed — $bcpCode');
          throw const TranslateException(TranslateFailure.modelDownloadFailed);
        }
        _log('Model downloaded — $bcpCode (${ms}ms)');
      } catch (error) {
        if (error is TranslateException) rethrow;
        _log('Model download error — $bcpCode: $error');
        throw const TranslateException(TranslateFailure.modelDownloadFailed);
      }
    }
  }

  Future<void> _ensureTranslator(
    mlkit.TranslateLanguage source,
    mlkit.TranslateLanguage target,
  ) async {
    if (_translator != null &&
        _cachedSource == source &&
        _cachedTarget == target) {
      _log('Reusing translator — ${source.bcpCode} → ${target.bcpCode}');
      return;
    }

    await _translator?.close();
    _log('Creating translator — ${source.bcpCode} → ${target.bcpCode}');
    _translator = mlkit.OnDeviceTranslator(
      sourceLanguage: source,
      targetLanguage: target,
    );
    _cachedSource = source;
    _cachedTarget = target;
  }

  Future<void> dispose() async {
    _log('Disposing translator');
    await _translator?.close();
    _translator = null;
    _cachedSource = null;
    _cachedTarget = null;
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[MlKitTranslate] $message');
    }
  }

  String _preview(String text, [int max = 80]) {
    if (text.length <= max) return text;
    return '${text.substring(0, max)}…';
  }
}

enum TranslateFailure {
  unsupportedLanguage,
  modelDownloadFailed,
  translationFailed,
}

class TranslateException implements Exception {
  const TranslateException(this.failure);

  final TranslateFailure failure;
}
