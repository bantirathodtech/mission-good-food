import 'package:flutter/material.dart';

import '../../core/navigation/navigation_helpers.dart';
import '../cart/presentation/view/screen/cart_screen.dart';
import '../main/main_screen.dart';
import '../pages/auth/1.splash/splash_screen.dart';
import '../pages/auth/2.onboarding/auth_option.dart';
import '../pages/auth/3.register/register_user_screen.dart';
import '../pages/auth/6.signin/signin_screen.dart';
import '../pages/auth/7.forget/forget_password_screen.dart';

/// A class to manage route names and navigation easily.
class AppRouteManager {
  // Define route names here
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String authOptions = '/auth-options';
  static const String mainScreen = '/main';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String favorite = '/favorite';
  static const String settings = '/settings';
  static const String productDetails = '/productDetails';
  // Add more routes as needed...

  // Navigation functions

  /// 1. Navigate to the Splash screen
  static void navigateToSplash(BuildContext context) {
    NavigationHelper.pushReplacement(context, const SplashScreen());
  }

  /// 2. Navigate to the Auth options screen
  static void navigateToAuthOption(BuildContext context) {
    NavigationHelper.push(context, const AuthOption());
  }

  /// 3. Navigate to the Login screen
  static void navigateToLogin(BuildContext context) {
    NavigationHelper.push(context, const SignInScreen());
  }

  /// 4. Navigate to the Register screen
  static void navigateToRegister(BuildContext context) {
    NavigationHelper.push(context, const RegisterUserScreen());
  }

  /// 5. Navigate to the Forgot Password screen
  static void navigateToForgotPassword(BuildContext context) {
    NavigationHelper.push(context, const ForgetPasswordScreen());
  }

  /// Handle back navigation for auth screens
  static void goBackToAuth(BuildContext context) {
    if (Navigator.canPop(context)) {
      NavigationHelper.pop(context);
    } else {
      navigateToAuthOption(context);
    }
  }

  /// Main App Navigation
  ///
  /// 6. Navigate to the Main screen
  static void navigateToMainAndClearStack(BuildContext context) {
    NavigationHelper.pushAndRemoveUntil(
        context, const MainScreen(), (route) => false);
  }

  /// 7. Navigate to the Home screen
  static void navigateToHome(BuildContext context) {
    NavigationHelper.pushNamed(context, home);
  }

  // /// Navigate to the Login screen
  // static void navigateToLogin(BuildContext context) {
  //   NavigationHelper.pushNamed(context, login);
  // }
  /// Navigate to the Dashboard screen
  // static void navigateToDashboard(BuildContext context) {
  //   NavigationHelper.pushNamed(context, dashboard);
  // }

  /// 8. Navigate to the Favorite screen
  static void navigateToFavorite(BuildContext context) {
    NavigationHelper.pushNamed(context, favorite);
  }

  /// 9. Navigate to the Cart screen
  static void navigateToCart(BuildContext context) {
    NavigationHelper.pushNamed(context, cart);
  }

  static void navigateToCartAndClearStack(BuildContext context) {
    NavigationHelper.pushAndRemoveUntil(
      context,
      const CartScreen(),
      (route) => false,
    );
  }

  /// 10 Navigate to the Profile screen
  static void navigateToProfile(BuildContext context) {
    NavigationHelper.pushNamed(context, profile);
  }

  /// Navigate to the Settings screen
  // static void navigateToSettings(BuildContext context) {
  //   NavigationHelper.pushNamed(context, settings);
  // }

  // static void navigateToProductDetails(BuildContext context, Product product) {
  //   NavigationHelper.pushNamed(context, productDetails, arguments: product);
  // }

  /// Replace the current screen with the Home screen
  static void replaceWithHome(BuildContext context) {
    NavigationHelper.pushNamedReplacement(context, home);
  }

  /// Navigate to the Dashboard and remove all previous screens from the stack
  static void navigateToDashboardAndClearStack(BuildContext context) {
    NavigationHelper.pushNamedAndRemoveUntil(
        context, dashboard, (route) => false);
  }

  /// Go back to the previous screen
  static void goBack(BuildContext context) {
    NavigationHelper.pop(context);
  }

  /// Pop until the login screen
  static void popUntilLogin(BuildContext context) {
    NavigationHelper.popUntil(context, login);
  }

  /// Pop until the home screen
  static void popUntilHome(BuildContext context) {
    NavigationHelper.popUntil(context, home);
  }

  /// Check if the user can go back in the navigation stack
  static bool canGoBack(BuildContext context) {
    return NavigationHelper.canPop(context);
  }

  /// Tab Navigation within Main Screen
  // static void navigateToHomeTab(BuildContext context) {
  //   if (context.mounted) {
  //     final mainScreenState =
  //         context.findAncestorStateOfType<MainScreenState>();
  //     mainScreenState?.navigateToHomeTab();
  //   }
  // }
  //
  // /// Replace current screen with a new one
  // static void replaceCurrent(BuildContext context, Widget screen) {
  //   NavigationHelper.pushReplacement(context, screen);
  // }

  /// Clear stack and push new screen
  static void clearStackAndPush(BuildContext context, Widget screen) {
    NavigationHelper.pushAndRemoveUntil(
      context,
      screen,
      (route) => false,
    );
  }

  /// push named route with arguments
  static void pushNamedWithArgs(
      BuildContext context, String routeName, Object? arguments) {
    NavigationHelper.pushNamed(context, routeName, arguments: arguments);
  }
}
/*

* */
