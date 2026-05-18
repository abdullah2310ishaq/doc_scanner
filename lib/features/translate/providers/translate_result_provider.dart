import 'package:flutter/foundation.dart';

import '../models/translate_language.dart';
import '../services/dummy_translate_service.dart';
import '../services/translate_service.dart';

class TranslateResultProvider extends ChangeNotifier {
  TranslateResultProvider({
    required this.sourceText,
    TranslateService? translateService,
  }) : _translateService = translateService ?? DummyTranslateService();

  final String sourceText;
  final TranslateService _translateService;

  TranslateLanguage? _selectedLanguage;
  String _translatedText = '';
  bool _isTranslating = false;
  String? _errorMessage;

  TranslateLanguage? get selectedLanguage => _selectedLanguage;
  String get translatedText => _translatedText;
  bool get isTranslating => _isTranslating;
  String? get errorMessage => _errorMessage;
  bool get hasTranslation => _translatedText.isNotEmpty;

  Future<void> selectLanguage(TranslateLanguage? language) async {
    _selectedLanguage = language;
    _translatedText = '';
    _errorMessage = null;
    notifyListeners();

    if (language == null || sourceText.trim().isEmpty) return;
    await _runTranslation(language);
  }

  Future<void> retryTranslation() async {
    final language = _selectedLanguage;
    if (language == null) return;
    await _runTranslation(language);
  }

  Future<void> _runTranslation(TranslateLanguage language) async {
    _isTranslating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _translatedText = await _translateService.translate(
        text: sourceText,
        targetLanguage: language,
      );
    } catch (error) {
      _translatedText = '';
      _errorMessage = error.toString();
    }

    _isTranslating = false;
    notifyListeners();
  }
}
