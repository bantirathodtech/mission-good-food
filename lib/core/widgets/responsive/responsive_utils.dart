import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Singleton pattern to avoid multiple instantiations
  static final ResponsiveUtils _instance = ResponsiveUtils._internal();

  factory ResponsiveUtils() => _instance;

  ResponsiveUtils._internal();

  // Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Get dynamic height as a fraction of the total height
  static double dynamicHeight(BuildContext context, double fraction) {
    return screenHeight(context) * fraction;
  }

  // Get dynamic width as a fraction of the total width
  static double dynamicWidth(BuildContext context, double fraction) {
    return screenWidth(context) * fraction;
  }

  // Determine if the device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Determine if the screen size is small (e.g., for phones)
  static bool isSmallScreen(BuildContext context) {
    return screenWidth(context) < 600;
  }

  // Determine if the screen size is large (e.g., for tablets)
  static bool isLargeScreen(BuildContext context) {
    return screenWidth(context) >= 600;
  }

  // Get adaptive font size
  static double adaptiveFontSize(BuildContext context, double baseSize) {
    return isSmallScreen(context)
        ? baseSize * 0.9
        : isLargeScreen(context)
            ? baseSize * 1.2
            : baseSize;
  }
}
