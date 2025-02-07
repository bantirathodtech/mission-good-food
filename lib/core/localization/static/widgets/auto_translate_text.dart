// 2. Create lib/widgets/auto_translate_text.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_translations.dart';

class AutoTranslateText extends StatelessWidget {
  final String text;
  final Map<String, String>? params;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final bool? select;

  const AutoTranslateText(
    this.text, {
    super.key,
    this.params,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.select,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTranslations>(
      builder: (context, translations, _) {
        String translatedText = params != null
            ? translations.translateWithParams(text, params!)
            : translations.translate(text);

        Widget textWidget = Text(
          translatedText,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

        // Only wrap with SelectableText if selection is enabled
        if (select ?? false) {
          return SelectableText(
            translatedText,
            style: style,
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textHeightBehavior: textHeightBehavior,
          );
        }
        return textWidget;
      },
    );
  }
}

// Example usage for text with parameters
/*
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Simple usage
        const AutoTranslateText(
          'welcome_message',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),

        // With parameters
        AutoTranslateText(
          'greeting_with_name',  // Translation key: "Hello {name}!"
          params: {'name': 'John'},
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // With text selection enabled
        const AutoTranslateText(
          'long_text',
          select: true,
          selectionColor: Colors.blue,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.2,
        ),

        // With text direction
        const AutoTranslateText(
          'rtl_text',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),

        // With custom locale
        const AutoTranslateText(
          'date_format',
          locale: Locale('hi', 'IN'),
          strutStyle: StrutStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
*/

// Add this method to your AppTranslations class
extension AppTranslationsExtension on AppTranslations {
  String translateWithParams(String key, Map<String, String> params) {
    String translation = translate(key);
    params.forEach((paramKey, value) {
      translation = translation.replaceAll('{$paramKey}', value);
    });
    return translation;
  }
}
