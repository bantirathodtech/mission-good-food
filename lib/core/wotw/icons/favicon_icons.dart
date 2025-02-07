// lib/icons/favicon_icons.dart

import 'package:flutter/material.dart';

class FaviconIcons {
  // Example of different favicon formats
  static const String faviconIco = 'assets/icons/favicon.ico';
  static const String faviconPng = 'assets/icons/favicon.png';
  static const String faviconSvg = 'assets/icons/favicon.svg';

  // Optionally, create an Icon widget if you want to display it
  static Widget getFavicon(String format) {
    switch (format) {
      case 'ico':
        return Image.asset(faviconIco);
      case 'png':
        return Image.asset(faviconPng);
      case 'svg':
        return Image.asset(faviconSvg); // Requires `flutter_svg` package
      default:
        return const Icon(Icons.error); // Default error icon
    }
  }
}
