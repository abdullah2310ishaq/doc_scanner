enum TranslateFailure {
  unsupportedLanguage,
  noInternet,
  modelDownloadFailed,
  translationFailed,
}

class TranslateException implements Exception {
  const TranslateException(this.failure);

  final TranslateFailure failure;
}
