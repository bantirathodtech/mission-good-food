// 3. Create lib/screens/language_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_translations.dart';
import '../static/widgets/auto_translate_text.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoTranslateText('select_language'),
      ),
      body: ListView(
        children: [
          _LanguageOption(
            languageCode: 'en',
            languageName: 'English',
            nativeName: 'English',
          ),
          _LanguageOption(
            languageCode: 'hi',
            languageName: 'Hindi',
            nativeName: 'हिंदी',
          ),
          _LanguageOption(
            languageCode: 'te',
            languageName: 'Telugu',
            nativeName: 'తెలుగు',
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String languageCode;
  final String languageName;
  final String nativeName;

  const _LanguageOption({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTranslations>(
      builder: (context, translations, _) {
        final isSelected =
            translations.currentLocale.languageCode == languageCode;

        return ListTile(
          title: Text(nativeName),
          subtitle: Text(languageName),
          trailing: isSelected ? const Icon(Icons.check) : null,
          onTap: () => translations.changeLanguage(languageCode),
        );
      },
    );
  }
}
