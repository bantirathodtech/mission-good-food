// 1. First, create a base translation mixin (lib/core/localization/translatable_mixin.dart)
// lib/core/localization/remote/mixin/translatable_mixin.dart
mixin TranslatableMixin {
  Map<String, dynamic>? _translations;
  
  // List of supported languages
  static const List<String> supportedLanguages = ['en', 'hi', 'te'];

  void setTranslationsFromResponse(Map<String, dynamic> json, List<String> fields) {
    final Map<String, dynamic> translations = {};
    
    // Handle different API response formats
    for (final lang in supportedLanguages) {
      translations[lang] = {};
      for (final field in fields) {
        if (json[field] is Map) {
          // Format: {"name": {"en": "value", "hi": "value"}}
          translations[lang][field] = json[field][lang] ?? json[field]['en'] ?? '';
        } else {
          // Format: {"name": "value"} - default to same value for all languages
          translations[lang][field] = json[field] ?? '';
        }
      }
    }
    
    _translations = translations;
  }

  String getTranslatedValue(String key, String languageCode) {
    if (_translations == null) return '';
    
    // Try requested language
    final value = _translations![languageCode]?[key];
    if (value != null && value.isNotEmpty) return value;
    
    // Fallback to English
    final enValue = _translations!['en']?[key];
    if (enValue != null && enValue.isNotEmpty) return enValue;
    
    // Fallback to any available translation
    for (final lang in supportedLanguages) {
      final fallbackValue = _translations![lang]?[key];
      if (fallbackValue != null && fallbackValue.isNotEmpty) return fallbackValue;
    }
    
    return '';
  }
}