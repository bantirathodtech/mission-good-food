import 'package:flutter/material.dart';

class AppTextStyles {
  static const String interFont = 'Inter';

  // Display Styles
  static TextStyle get displayLarge => const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        fontFamily: interFont,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w500,
        fontFamily: interFont,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        fontFamily: interFont,
      );

  // Headline Styles
  static TextStyle get headlineLarge => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: interFont,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        fontFamily: interFont,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: interFont,
      );

  // Title Styles
  static TextStyle get titleLarge => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        fontFamily: interFont,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: interFont,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: interFont,
      );

  // Body Styles
  static TextStyle get bodyLarge => const TextStyle(
        fontSize: 18,
        fontFamily: interFont,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontSize: 16,
        fontFamily: interFont,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 14,
        fontFamily: interFont,
      );

  // Label Styles
  static TextStyle get labelLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        fontFamily: interFont,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        fontFamily: interFont,
      );

  static TextStyle get labelSmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        fontFamily: interFont,
      );

  static TextTheme get theme => TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );
}
