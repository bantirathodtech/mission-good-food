import 'package:flutter/material.dart';

/// A utility class for handling various types of navigation in a Flutter app.
class NavigationHelper {
/*
  Pushes a new page onto the navigation stack.
  **Use Case**: When you want to navigate to a new screen and keep the current one in the stack.
  Example: NavigationHelper.push(context, NewScreen());
*/
  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

/*
  Pushes a new page and replaces the current one in the stack.
  **Use Case**: When you want to navigate to a new screen and remove the current screen to prevent returning to it.
  Example: NavigationHelper.pushReplacement(context, NewScreen());
*/

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

/*
  Pushes a named route onto the navigation stack.
  **Use Case**: When you are using named routes defined in your `MaterialApp` for navigation.
  Example: NavigationHelper.pushNamed(context, '/home', arguments: {'id': 1});
*/

  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

/*
   Pushes a named route and removes the current one from the stack.
   **Use Case**: When navigating to a named route and ensuring the current screen is removed.
   Example:NavigationHelper.pushNamedReplacement(context, '/home');
*/

  static Future<T?> pushNamedReplacement<T extends Object?, TO extends Object?>(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

/*
  Pushes a named route and removes all previous routes from the stack.
  **Use Case**: When navigating to a screen and clearing the navigation history (e.g., after login or onboarding).
  Example:NavigationHelper.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
*/

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
      BuildContext context,
      String routeName,
      bool Function(Route<dynamic>) predicate,
      {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      predicate,
      arguments: arguments,
    );
  }

/*
  Pushes a new page and removes all previous pages from the stack.
  **Use Case**: When you want to navigate to a new screen and clear the navigation history (e.g., reset the app state).
  Example: NavigationHelper.pushAndRemoveUntil(context, NewScreen(), (route) => false);
*/

  static Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context,
      Widget page, bool Function(Route<dynamic>) predicate) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      predicate,
    );
  }

/*
  Pops the current page and returns to the previous one.
  **Use Case**: When you want to go back to the previous screen.
  Example: NavigationHelper.pop(context);
*/

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// Pops all screens until a specific route name is reached.
  /// **Use Case**: When you want to return to a specific screen by its route name.
  /// Example:
  /// NavigationHelper.popUntil(context, '/home');

  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

/*
  Checks whether the navigation stack can be popped.
  **Use Case**: To check if the user can go back in the navigation stack before attempting to pop.
  Example:
  if (NavigationHelper.canPop(context)) {
  NavigationHelper.pop(context);  }
*/

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }

/*
  Replaces the top-most route with a new page.
  **Use Case**: When you want to replace the current screen with another without adding to the stack.
  Example:
  NavigationHelper.popAndPush(context, NewScreen());
*/

  static Future<T?> popAndPush<T extends Object?, TO extends Object?>(
      BuildContext context, Widget page,
      {TO? result}) {
    return Navigator.popAndPushNamed(
      context,
      MaterialPageRoute(builder: (context) => page).toString(),
      result: result,
    );
  }
}
