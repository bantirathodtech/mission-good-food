import 'package:flutter/material.dart';

import '../features/main/main_screen.dart';
import '../features/routes/app_route_manager.dart';

class MainScreenNavigationWithConfirmation {
  static DateTime? _lastBackPressTime;

  static Future<bool> handleMainScreenBack(
      BuildContext context, int currentIndex) async {
    if (currentIndex != 0) {
      navigateToTab(context, 0);
      return false;
    }

    final DateTime now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  static void navigateToTab(BuildContext context, int index) {
    if (context.mounted) {
      final mainScreenState =
          context.findAncestorStateOfType<MainScreenState>();
      if (mainScreenState != null) {
        mainScreenState.setSelectedIndex(index);
      }
    }
  }

  static void popToHomeTab(BuildContext context) {
    navigateToTab(context, 0);
  }

  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App?'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => AppRouteManager.goBack(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
