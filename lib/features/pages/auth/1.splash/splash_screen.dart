import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';

import '../../../../core/data/share_preference/app_preferences.dart';
import '../../../../core/log/loggers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    try {
      // Reduce delay to minimum - only enough to show the splash screen
      await Future.delayed(const Duration(milliseconds: 800));

      // Perform login check concurrently with splash screen display
      Map<String, dynamic> userData = await AppPreference.getUserData();

      // Check if user is logged in
      bool isLoggedIn = userData.isNotEmpty;

      // Log the login status
      AppLogger.logInfo('User login status: $isLoggedIn');

      if (isLoggedIn) {
        // Log user data
        AppLogger.logInfo('User data: $userData');
        AppLogger.logInfo(
            'User phone number: ${userData['phone'] ?? 'No phone number'}');

        AppLogger.logDebug('Navigating to MainScreen');
        AppRouteManager.navigateToMainAndClearStack(context);
      } else {
        AppLogger.logDebug('Navigating to AuthOption');
        AppRouteManager.navigateToAuthOption(context);
      }
    } catch (e) {
      AppLogger.logError('Error checking login status: $e');
      // In case of error, navigate to login screen
      AppRouteManager.navigateToLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/splash_screen.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
