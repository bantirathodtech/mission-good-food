import 'package:flutter/material.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../../core/widgets/form/custom_form_field.dart';
import '../../../../core/widgets/pattern/line/line_widget.dart';
import '../5.password/create_new_password_screen.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final _fullNameController = TextEditingController();

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
              'Verify',
              style: GlobalTextStyles.qsTitle,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50], // Set the background color here
        child: Column(
          children: [
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Verify Account',
                          style: GlobalTextStyles.qs22w7Green,

                          // style: TextStyle(
                          //   fontSize: 22,
                          //   fontWeight: FontWeight.w700,
                          //   color: Color(0xFF4CAF50),
                          // ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Code has been send to",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "prathab@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Enter the code to verify your account.",
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomFormField(
                      controller: _fullNameController,
                      // labelText: 'Full Name',
                      hintText: '4 Digit Code',
                      hintStyle: GlobalTextStyles.regular4SlateGrey,
                      // hintText: 'Enter your full name',
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  // TextFormField(
                  //   // controller: _emailController,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.grey[200],
                  //     // prefixIcon:
                  //     //     const Icon(Icons.email_outlined, color: Colors.green),
                  //     hintText: '4 Digit Code',
                  //     hintStyle: TextStyle(
                  //       fontSize: 14, // Set the desired font size
                  //       color: Color.fromRGBO(
                  //           138, 141, 159, 1), // Set the desired color
                  //       fontWeight:
                  //           FontWeight.w400, // Optional: Adjust font weight
                  //     ),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn't Received Code?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Resend Code",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(148, 163, 184, 1),
                                fontWeight: FontWeight.w600,
                                decoration:
                                    TextDecoration.underline, // Adds underline
                                decorationColor: Color.fromRGBO(148, 163, 184,
                                    1), // Matches underline color with text color
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Resend Code in",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "00:59",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => CreateNewPasswordScreen()),
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
                        'Verify Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 310),
                  // const Spacer(), // Dynamically takes up available space
                ],
              ),
            ),
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
