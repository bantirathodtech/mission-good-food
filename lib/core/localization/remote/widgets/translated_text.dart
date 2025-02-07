// 4. Create a TranslatedText widget (lib/core/localization/widgets/translated_text.dart)
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../provider/app_translations.dart';
import '../models/base_translatable_model.dart';

class TranslatedText extends StatelessWidget {
  final BaseTranslatableModel model;
  final String Function(String) translationGetter;
  final TextStyle? style;
  final TextAlign? textAlign;
  // Add other Text widget properties as needed

  const TranslatedText({
    super.key,
    required this.model,
    required this.translationGetter,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTranslations>(
      builder: (context, translations, _) {
        final translatedText =
            translationGetter(translations.currentLocale.languageCode);

        return Text(
          translatedText,
          style: style,
          textAlign: textAlign,
        );
      },
    );
  }
}
