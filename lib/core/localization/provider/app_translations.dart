// 1. First, create lib/localization/app_translations.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTranslations extends ChangeNotifier {
  static final AppTranslations _instance = AppTranslations._internal();
  factory AppTranslations() => _instance;
  AppTranslations._internal();

  late Map<String, Map<String, String>> _translations = {};
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  // Initialize translations from JSON files
  Future<void> init() async {
    // Load translations for each supported language
    for (String lang in ['en', 'hi', 'te']) {
      String jsonContent =
          await rootBundle.loadString('assets/translations/$lang.json');
      _translations[lang] = Map<String, String>.from(json.decode(jsonContent));
    }

    // Load saved language preference
    final prefs = await SharedPreferences.getInstance();
    String? savedLang = prefs.getString('selectedLanguage');
    if (savedLang != null) {
      _currentLocale = Locale(savedLang);
    }
  }

  // Change language and notify listeners
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLocale.languageCode != languageCode) {
      _currentLocale = Locale(languageCode);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedLanguage', languageCode);
      notifyListeners();
    }
  }

  // Get translation for a key
  String translate(String key) {
    return _translations[_currentLocale.languageCode]?[key] ?? key;
  }
}
