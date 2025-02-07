import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../../core/widgets/form/custom_form_field.dart';
import '../../../../core/widgets/pattern/line/line_widget.dart';
import '../../../main/main_screen.dart';
import '../../../routes/app_route_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: greenShadowDecoration, // Applying the reusable decoration
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color.fromRGBO(200, 230, 200, 1),
          //       blurRadius: 100,
          //       spreadRadius: 0,
          //       offset: Offset(0, 5),
          //     ),
          //   ],
          // ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              // onPressed: () => Navigator.pop(context),
              onPressed: () => AppRouteManager.navigateToAuthOption(context),
            ),
            title: Text(
              'Forgot Password',
              style: GlobalTextStyles.qsTitle,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Forgot Password',
                          style: GlobalTextStyles.qs22w7Green,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No worries! Enter your email address below and",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Center(
                          child: Text(
                            "we will send you a code to reset password.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomFormField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        _showPasswordResetPopup(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#4FA56F"),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
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

  void _showPasswordResetPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: HexColor("#F0F0F0"),
          child: SizedBox(
            width: 315,
            height: 201,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        'Password Reset Email Sent',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'An email has been sent to you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(38, 43, 46, 1),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Follow directions in the email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(38, 43, 46, 1),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'to reset your password.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(38, 43, 46, 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#4FA56F"),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(130, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'OK',
                          style: GlobalTextStyles.roboto16w7White,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
