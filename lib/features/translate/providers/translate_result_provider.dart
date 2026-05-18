import 'package:flutter/foundation.dart';

import '../models/translate_language.dart';
import '../services/mlkit_translate_service.dart';
import '../services/openai_translate_service.dart';
import '../services/translate_errors.dart';
import '../services/translate_service.dart';

class TranslateResultProvider extends ChangeNotifier {
  TranslateResultProvider({
    required this.sourceText,
    TranslateService? translateService,
    this.sourceLanguageCode = 'en',
    bool Function()? isOnline,
  })  : _translateService = translateService ?? OpenAiTranslateService(),
        _isOnline = isOnline ?? (() => true);

  final String sourceText;
  final String sourceLanguageCode;
  final TranslateService _translateService;
  final bool Function() _isOnline;

  TranslateLanguage? _selectedLanguage;
  String _translatedText = '';
  bool _isTranslating = false;
  TranslateFailure? _failure;

  TranslateLanguage? get selectedLanguage => _selectedLanguage;
  String get translatedText => _translatedText;
  bool get isTranslating => _isTranslating;
  TranslateFailure? get translateFailure => _failure;
  String? get errorMessage => _failure?.name;
  bool get hasTranslation => _translatedText.isNotEmpty;

  Future<void> selectLanguage(TranslateLanguage? language) async {
    _selectedLanguage = language;
    _translatedText = '';
    _failure = null;
    notifyListeners();

    if (language == null) {
      _log('Language cleared');
      return;
    }
    if (sourceText.trim().isEmpty) {
      _log('Skipped translation — source text is empty');
      return;
    }
    await _runTranslation(language);
  }

  Future<void> retryTranslation() async {
    final language = _selectedLanguage;
    if (language == null) return;
    _log('Retry translation → ${language.name} (${language.code})');
    await _runTranslation(language);
  }

  Future<void> _runTranslation(TranslateLanguage language) async {
    if (!_isOnline()) {
      _translatedText = '';
      _failure = TranslateFailure.noInternet;
      notifyListeners();
      _log('Skipped translation — no internet');
      return;
    }

    _isTranslating = true;
    _failure = null;
    notifyListeners();

    final startedAt = DateTime.now();
    _log(
      'Started — target: ${language.name} (${language.code}), '
      'source: $sourceLanguageCode, chars: ${sourceText.length}',
    );

    try {
      _translatedText = await _translateService.translate(
        text: sourceText,
        targetLanguage: language,
        sourceLanguageCode: sourceLanguageCode,
      );
      final ms = DateTime.now().difference(startedAt).inMilliseconds;
      _log(
        'Success in ${ms}ms — result chars: ${_translatedText.length}, '
        'preview: ${_preview(_translatedText)}',
      );
    } on TranslateException catch (error) {
      _translatedText = '';
      _failure = error.failure;
      _log('Failed — ${error.failure.name}');
    } catch (error, stack) {
      _translatedText = '';
      _failure = TranslateFailure.translationFailed;
      _log('Failed — unexpected: $error\n$stack');
    }

    _isTranslating = false;
    notifyListeners();
  }

  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[TranslateProvider] $message');
    }
  }

  String _preview(String text, [int max = 80]) {
    if (text.length <= max) return text;
    return '${text.substring(0, max)}…';
  }

  @override
  void dispose() {
    final service = _translateService;
    if (service is MlKitTranslateService) {
      service.dispose();
    }
    super.dispose();
  }
}
