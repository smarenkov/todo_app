import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale.fromSubtags(languageCode: languageCode);
    await _saveLocale(languageCode);

    notifyListeners();
  }

  Future<void> _loadLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString('language_code');

    if (languageCode != null) {
      _locale = Locale.fromSubtags(languageCode: languageCode);

      notifyListeners();
    }
  }

  Future<void> _saveLocale(String languageCode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('language_code', languageCode);
  }
}
