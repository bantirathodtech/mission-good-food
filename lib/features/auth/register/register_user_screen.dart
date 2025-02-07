// import 'package:flutter/material.dart';
// import 'package:good_food_app/features/routes/app_route_manager.dart';
//
// import '../../../core/decoration/single_side_shadow_decoration.dart';
// import '../../../core/theme/text_styles/global_text_style.dart';
// import '../../../core/widgets/form/custom_form_field.dart';
// import '../../../core/widgets/pattern/line/line_widget.dart';
// import '../../verify/verify_account_screen.dart';
//
// class RegisterUserScreen extends StatefulWidget {
//   const RegisterUserScreen({super.key});
//
//   @override
//   State<RegisterUserScreen> createState() => _RegisterUserScreenState();
// }
//
// class _RegisterUserScreenState extends State<RegisterUserScreen> {
//   final _fullNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   // bool _isPasswordVisible = false;
//   // bool _isConfirmPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: greenShadowDecoration, // Applying the reusable decoration
//
//           // decoration: BoxDecoration(
//           //   color: Colors.white, // AppBar background color
//           //   boxShadow: [
//           //     BoxShadow(
//           //       color: Color.fromRGBO(
//           //           200, 230, 200, 1), // Lighter green shadow color
//           //       blurRadius: 200, // Controls the softness of the shadow
//           //       spreadRadius: 0, // Controls the spread of the shadow
//           //       offset: Offset(0, 5), // Moves the shadow downward
//           //     ),
//           //   ],
//           // ),
//           child: AppBar(
//             backgroundColor:
//                 Colors.transparent, // Make the AppBar itself transparent
//             elevation: 0, // Disable default elevation
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               // onPressed: () => Navigator.pop(context),
//               onPressed: () => AppRouteManager.navigateToAuthOption(context),
//             ),
//             title: Text(
//               'Register',
//               style: GlobalTextStyles.qsTitle,
//             ),
//             centerTitle: true,
//           ),
//         ),
//       ),
//
//       // appBar: AppBar(
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       //   title: const Text(
//       //     'Register',
//       //     style: GlobalTextStyles.text22_7_b,
//       //     // style: TextStyle(
//       //     //   fontSize: 22,
//       //     //   fontWeight: FontWeight.w700,
//       //     // ),
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.white,
//       // ),
//       body: Container(
//         // color: Colors.white70, // Set the background color here
//         color: Colors.grey[50], // Set the background color here
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 36),
//                     Text(
//                       'Create a new account',
//                       style: GlobalTextStyles.qs22w7Green,
//
//                       // style: TextStyle(
//                       //   fontSize: 22,
//                       //   fontWeight: FontWeight.w700,
//                       //   color: Colors.green,
//                       // ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 24),
//                         CustomFormField(
//                           controller: _fullNameController,
//                           // labelText: 'Full Name',
//                           hintText: 'Full Name',
//                           hintStyle: GlobalTextStyles.regular4SlateGrey,
//                           // hintText: 'Enter your full name',
//                           textStyle: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         const SizedBox(height: 24),
//                         CustomFormField(
//                           controller: _lastNameController,
//                           // labelText: 'Last Name',
//                           hintText: 'Last Name',
//                           hintStyle: GlobalTextStyles.regular4SlateGrey,
//
//                           // hintText: 'Enter your last name',
//                         ),
//                         const SizedBox(height: 24),
//                         CustomFormField(
//                           controller: _emailController,
//                           // labelText: 'Email',
//                           hintText: 'Email',
//                           hintStyle: GlobalTextStyles.regular4SlateGrey,
//
//                           // hintText: 'Enter your email',
//                           keyboardType: TextInputType.emailAddress,
//                           // prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 24),
//                         CustomFormField(
//                           controller: _passwordController,
//                           // labelText: 'Password',
//                           hintText: 'Password',
//                           hintStyle: GlobalTextStyles.regular4SlateGrey,
//
//                           // hintText: 'Enter your password',
//                           // obscureText: !_isPasswordVisible,
//                           // prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                           // suffixIcon: IconButton(
//                           //   icon: Icon(
//                           //     _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                           //     color: Colors.grey,
//                           //   ),
//                           //   onPressed: () {
//                           //     // setState(() {
//                           //     //   _isPasswordVisible = !_isPasswordVisible;
//                           //     // });
//                           //   },
//                           // ),
//                         ),
//                         const SizedBox(height: 24),
//                         CustomFormField(
//                           controller: _confirmPasswordController,
//                           // labelText: 'Confirm Password',
//                           hintText: 'Confirm Password',
//                           hintStyle: GlobalTextStyles.regular4SlateGrey,
//
//                           // hintText: 'Confirm your password',
//                           // obscureText: !_isConfirmPasswordVisible,
//                           // prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                           // suffixIcon: IconButton(
//                           //   icon: Icon(
//                           //     _isConfirmPasswordVisible
//                           //         ? Icons.visibility_off
//                           //         : Icons.visibility,
//                           //     color: Colors.grey,
//                           //   ),
//                           //   onPressed: () {
//                           //     // setState(() {
//                           //     //   _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//                           //     // }
//                           //     // );
//                           //   },
//                           // ),
//                         ),
//                         const SizedBox(height: 80),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                   builder: (context) => VerifyAccountScreen()),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF4CAF50),
//                             foregroundColor: Colors.white,
//                             minimumSize: const Size(double.infinity, 44),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Create Account',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         const Center(
//                           child: Column(
//                             children: [
//                               Text(
//                                 "By continuing, you agree to our",
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Terms of Service",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w500,
//                                       // color: Color(0xFF4CAF50),
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                   Text(
//                                     " and ",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Privacy Policy",
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w500,
//                                       // color: Color(0xFF4CAF50),
//                                       color: Colors.blue,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     // const SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: LineWidget(
//                   length: 200,
//                   thickness: 5,
//                   color: const Color.fromRGBO(29, 191, 115, 1),
//                   borderRadius: 12.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
// }
