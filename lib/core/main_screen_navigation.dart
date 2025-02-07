import 'package:flutter/cupertino.dart';

import '../features/main/main_screen.dart';

class MainScreenNavigation {
  static Future<bool> handleMainScreenBack(
      BuildContext context, int currentIndex) async {
    if (currentIndex != 0) {
      popToHomeTab(context);
      return false; // Prevent app exit
    }
    return true; // On home tab, allow direct exit
  }

  static void navigateToTab(BuildContext context, int index) {
    if (context.mounted) {
      final mainScreenState =
          context.findAncestorStateOfType<MainScreenState>();
      if (mainScreenState != null) {
        mainScreenState.setSelectedIndex(index); // This was the issue
      }
    }
  }

  static void popToHomeTab(BuildContext context) {
    navigateToTab(context, 0);
  }
}
