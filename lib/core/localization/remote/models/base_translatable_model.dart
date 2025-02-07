// 2. Create a base model class (lib/core/models/base_translatable_model.dart)
import '../mixin/translatable_mixin.dart';

abstract class BaseTranslatableModel with TranslatableMixin {
  Map<String, dynamic> toJson();

  // Helper method to extract translations from API response
  Map<String, dynamic> extractTranslations(
      Map<String, dynamic> json, List<String> translatableFields) {
    final Map<String, dynamic> translations = {};

    for (final field in translatableFields) {
      if (json[field] is Map) {
        for (final entry in (json[field] as Map<String, dynamic>).entries) {
          translations[entry.key] ??= {};
          translations[entry.key][field] = entry.value;
        }
      }
    }

    return translations;
  }
}
