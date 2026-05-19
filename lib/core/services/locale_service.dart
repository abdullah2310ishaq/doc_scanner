import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/prefs_keys.dart';

/// Persists and exposes the active app [Locale].
class LocaleService extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(PrefsKeys.appLocaleCode) ?? 'en';
    _locale = Locale(code);
    notifyListeners();
  }

  Locale getCurrentLocale() => _locale;

  Future<void> setLocaleByCode(String languageCode) async {
    if (_locale.languageCode == languageCode) {
      return;
    }
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefsKeys.appLocaleCode, languageCode);
    notifyListeners();
  }
}
