import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';

import '../../../../core/localization/static/widgets/auto_translate_text.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';

class AuthOption extends StatelessWidget {
  const AuthOption({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          fit: StackFit.expand, // Make stack fill the available space
          children: [
            Positioned(
              left: -20,
              // Extend beyond screen
              right: -20,
              // Extend beyond screen
              top: 0,
              bottom: 0,
              child: StaggeredGrid.count(
                crossAxisCount: 4, // Using 4 columns for better ratio control
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  // Left column (1 part)
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile(
                      imagePath: 'assets/images/top_left.png',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),

                  // Center column (2 parts)
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: ImageTile(
                      imagePath: 'assets/images/top_center.png',
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),

                  // Right column (1 part)
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile(
                      imagePath: 'assets/images/top_right.png',
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),

                  // Bottom row tiles following same pattern
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 3,
                    child: ImageTile(
                      imagePath: 'assets/images/bottom_left.png',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  //
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile(
                      imagePath: 'assets/images/bottom_center.png',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 3,
                    child: ImageTile(
                      imagePath: 'assets/images/bottom_right.png',
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            // Auth Container (Fixed positioning)
            Positioned(
              top: screenHeight * 0.51,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 20, 32, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoTranslateText
                            // Text
                            ('Get Started Today',
                                style: GlobalTextStyles.qs24w7Black
                                // TextStyle(
                                //   fontSize: 24,
                                //   fontWeight: FontWeight.w700,
                                //   color: Colors.black,
                                // ),
                                ),
                        const SizedBox(height: 30),

                        // Logo
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          height: 60,
                          width: 200,
                        ),
                        const SizedBox(height: 44),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouteManager.navigateToLogin(context);
                            },
                            // onPressed: () {
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const SignInScreen()),
                            //   );
                            // },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(239, 164, 200, 1),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Google Sign In Button
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton(
                            onPressed: () {
                              // Handle Google sign in
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(color: Colors.black),
                              backgroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/google_icon.svg',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Login with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Registration Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color.fromRGBO(43, 41, 31, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppRouteManager.navigateToRegister(context);
                              },
                              // onTap: () {
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const RegisterUserScreen()),
                              //   );
                              // },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  final String imagePath;
  final BorderRadius? borderRadius;

  const ImageTile({
    super.key,
    required this.imagePath,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
