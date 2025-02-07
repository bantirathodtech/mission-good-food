import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../../core/widgets/form/custom_form_field.dart';
import '../../../../core/widgets/pattern/line/line_widget.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: greenShadowDecoration, // Applying the reusable decoration

          // decoration: BoxDecoration(
          //   color: Colors.white, // AppBar background color
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color.fromRGBO(
          //           200, 230, 200, 1), // Lighter green shadow color
          //       blurRadius: 200, // Controls the softness of the shadow
          //       spreadRadius: 0, // Controls the spread of the shadow
          //       offset: Offset(0, 5), // Moves the shadow downward
          //     ),
          //   ],
          // ),
          child: AppBar(
            backgroundColor:
                Colors.transparent, // Make the AppBar itself transparent
            elevation: 0, // Disable default elevation
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              // onPressed: () => Navigator.pop(context),
              onPressed: () => AppRouteManager.navigateToAuthOption(context),
            ),
            title: Text(
              'Create',
              style: GlobalTextStyles.qsTitle,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50], // Background color
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Create New Password',
                            style: GlobalTextStyles.qs22w7Green,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Please enter and confirm your new password",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            "You will need to login after you reset.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Password field
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //     hintText: 'Password',
                    //     hintStyle: const TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14,
                    //       color: Color.fromRGBO(138, 141, 159, 1),
                    //     ),
                    //     suffixIcon: Padding(
                    //       padding: const EdgeInsets.all(13),
                    //       child: SvgPicture.asset(
                    //         'assets/icons/ic_fi_eye-off.svg',
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    CustomFormField(
                      controller: _passwordController,
                      // labelText: 'Full Name',
                      hintText: 'Password',
                      hintStyle: GlobalTextStyles.regular4SlateGrey,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(13),
                        child: SvgPicture.asset(
                          'assets/icons/ic_fi_eye-off.svg',
                          fit: BoxFit.contain,
                        ),
                      ), // hintText: 'Enter your full name',
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Must contain 8 char...",
                            style: GlobalTextStyles.compact4Grey,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Confirm password field
                    CustomFormField(
                      controller: _confirmPasswordController,
                      // labelText: 'Full Name',
                      hintText: 'Confirm Password',
                      hintStyle: GlobalTextStyles.regular4SlateGrey,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(13),
                        child: SvgPicture.asset(
                          'assets/icons/ic_fi_eye-off.svg',
                          fit: BoxFit.contain,
                        ),
                      ), // hintText: 'Enter your full name',
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),

                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.grey[200],
                    //     hintText: 'Confirm Password',
                    //     hintStyle: const TextStyle(
                    //       fontWeight: FontWeight.w400,
                    //       fontSize: 14,
                    //       color: Color.fromRGBO(138, 141, 159, 1),
                    //     ),
                    //     suffixIcon: Padding(
                    //       padding: const EdgeInsets.all(13),
                    //       child: SvgPicture.asset(
                    //         'assets/icons/ic_fi_eye-off.svg',
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 60),
                    // Reset password button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CreateNewPasswordScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#4FA56F"),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // LineWidget at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: LineWidget(
                  length: 200,
                  thickness: 5,
                  color: const Color.fromRGBO(29, 191, 115, 1),
                  borderRadius: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
