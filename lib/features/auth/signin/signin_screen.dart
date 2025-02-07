// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../core/decoration/single_side_shadow_decoration.dart';
// import '../../../core/theme/text_styles/global_text_style.dart';
// import '../../../core/widgets/form/custom_form_field.dart';
// import '../../../core/widgets/pattern/line/line_widget.dart';
// import '../../main/main_screen.dart';
// import '../../routes/app_route_manager.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   LoginScreenState createState() => LoginScreenState();
// }
//
// class LoginScreenState extends State<SignInScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _rememberMe = false;
//   bool _isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           // decoration: BoxDecoration(
//           //   color: Colors.white, // AppBar background color
//           //   boxShadow: [
//           //     BoxShadow(
//           //       color: Color.fromRGBO(
//           //           228, 242, 228, 0.6), // Lighter green shadow color
//           //       blurRadius: 15, // Controls the softness of the shadow
//           //       spreadRadius: 1, // Controls the spread of the shadow
//           //       offset: Offset(0, 8), // Moves the shadow downward
//           //     ),
//           //   ],
//           // ),
//           decoration: greenShadowDecoration, // Applying the reusable decoration
//           child: AppBar(
//             backgroundColor: Colors.transparent,
//             // Make the AppBar itself transparent
//             elevation: 0,
//             // Disable default elevation
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.pop(context),
//               // onPressed: () => AppRouteManager.navigateToAuthOption(context),
//             ),
//             title: Text(
//               'Login',
//               style: GlobalTextStyles.qsTitle,
//             ),
//             centerTitle: true,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 Center(
//                   child: Column(
//                     children: [
//                       // const Text(
//                       //   'Welcome Back John!',
//                       //   style: TextStyle(
//                       //     fontSize: 22,
//                       //     fontWeight: FontWeight.w700,
//                       //     color: Color(0xFF4CAF50),
//                       //   ),
//                       // ),
//                       SvgPicture.asset(
//                         'assets/images/Welcome_Back_.svg',
//                         height: 28,
//                         width: 220,
//                       ),
//                       const SizedBox(height: 4),
//                       const Text(
//                         'Login to continue',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: CustomFormField(
//                     controller: _emailController,
//                     // labelText: 'E-mail',
//                     hintText: 'johndoe@mail.com',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black87,
//                     ),
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: SvgPicture.asset(
//                         'assets/icons/ic_email.svg',
//                         color:
//                             Colors.green, // Optional: Change color of the SVG
//                         height: 14.61, // Adjust size as needed
//                         width: 18.26,
//                       ),
//                     ),
//
//                     // hintText: 'Enter your password',
//                     // obscureText: !_isPasswordVisible,
//                     // prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                     // suffixIcon: IconButton(
//                     //   icon: Icon(
//                     //     _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                     //     color: Colors.grey,
//                     //   ),
//                     //   onPressed: () {
//                     //     // setState(() {
//                     //     //   _isPasswordVisible = !_isPasswordVisible;
//                     //     // });
//                     //   },
//                     // ),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 //   child: TextFormField(
//                 //     controller: _emailController,
//                 //     decoration: InputDecoration(
//                 //       filled: true,
//                 //       fillColor: Colors.grey[100],
//                 //       // prefixIcon: const Icon(Icons.email_outlined, color: Colors.green),
//                 //       prefixIcon: Padding(
//                 //         padding: const EdgeInsets.all(
//                 //             12.0), // Adjust padding to fit the SVG
//                 //         child: SvgPicture.asset(
//                 //           'assets/icons/ic_email.svg',
//                 //           color:
//                 //               Colors.green, // Optional: Change color of the SVG
//                 //           height: 14.61, // Adjust size as needed
//                 //           width: 18.26,
//                 //         ),
//                 //       ),
//                 //       hintText: 'johndoe@mail.com',
//                 //       border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(12),
//                 //         borderSide: BorderSide.none,
//                 //       ),
//                 //       enabledBorder: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(12),
//                 //         borderSide: BorderSide.none,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 24),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: CustomFormField(
//                     controller: _passwordController,
//                     // labelText: 'Password',
//                     prefixIcon: Padding(
//                       padding: const EdgeInsets.all(
//                           12.0), // Adjust padding to fit the SVG
//                       child: SvgPicture.asset(
//                         'assets/icons/ic_password.svg',
//                         color:
//                             Colors.green, // Optional: Change color of the SVG
//                         height: 19.05, // Adjust size as needed
//                         width: 16.67,
//                       ),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: _isPasswordVisible
//                           ? Icon(
//                               Icons.visibility,
//                               color: Colors.grey,
//                             )
//                           : SvgPicture.asset(
//                               'assets/icons/ic_fi_eye-off.svg',
//                               // color: Colors.green, // Optional: Change color of the SVG
//                               height: 18.48, // Adjust size as needed
//                               width: 18.48,
//                             ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     hintText: '********************',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black87,
//                     ),
//                     // hintText: 'Enter your password',
//                     // obscureText: !_isPasswordVisible,
//                     // prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                     // suffixIcon: IconButton(
//                     //   icon: Icon(
//                     //     _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//                     //     color: Colors.grey,
//                     //   ),
//                     //   onPressed: () {
//                     //     // setState(() {
//                     //     //   _isPasswordVisible = !_isPasswordVisible;
//                     //     // });
//                     //   },
//                     // ),
//                   ),
//                 ),
//
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 12),
//                 //   child: TextFormField(
//                 //     controller: _passwordController,
//                 //     obscureText: !_isPasswordVisible,
//                 //     decoration: InputDecoration(
//                 //       filled: true,
//                 //       fillColor: Colors.grey[100],
//                 //       // prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
//                 //       prefixIcon: Padding(
//                 //         padding: const EdgeInsets.all(
//                 //             12.0), // Adjust padding to fit the SVG
//                 //         child: SvgPicture.asset(
//                 //           'assets/icons/ic_password.svg',
//                 //           color:
//                 //               Colors.green, // Optional: Change color of the SVG
//                 //           height: 19.05, // Adjust size as needed
//                 //           width: 16.67,
//                 //         ),
//                 //       ),
//                 //       suffixIcon: IconButton(
//                 //         icon: _isPasswordVisible
//                 //             ? SvgPicture.asset(
//                 //                 'assets/icons/ic_fi_eye-off.svg',
//                 //                 // color: Colors.green, // Optional: Change color of the SVG
//                 //                 height: 18.48, // Adjust size as needed
//                 //                 width: 18.48,
//                 //               )
//                 //             : Icon(
//                 //                 Icons.visibility,
//                 //                 color: Colors.grey,
//                 //               ),
//                 //         onPressed: () {
//                 //           setState(() {
//                 //             _isPasswordVisible = !_isPasswordVisible;
//                 //           });
//                 //         },
//                 //       ),
//                 //       hintText: '********************',
//                 //       border: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(12),
//                 //         borderSide: BorderSide.none,
//                 //       ),
//                 //       enabledBorder: OutlineInputBorder(
//                 //         borderRadius: BorderRadius.circular(12),
//                 //         borderSide: BorderSide.none,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 12),
//                 Row(
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: _rememberMe,
//                           onChanged: (value) {
//                             setState(() {
//                               _rememberMe = value ?? false;
//                             });
//                           },
//                           activeColor: const Color(0xFF4CAF50),
//                         ),
//                         const Text(
//                           'Remember me',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                     // const SizedBox(
//                     //   width: 8,
//                     // ),
//                     TextButton(
//                       onPressed: () {
//                         AppRouteManager.navigateToForgotPassword(context);
//                       },
//                       // onPressed: () {
//                       //   Navigator.of(context).pushReplacement(
//                       //     MaterialPageRoute(
//                       //         builder: (context) => ForgetPasswordScreen()),
//                       //   );
//                       // },
//                       child: const Text(
//                         'Forget password ?',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 24),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: ElevatedButton(
//                     // onPressed: () {
//                     //   AppRouteManager.navigateToMainAndClearStack(context);
//                     // },
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => MainScreen()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromRGBO(79, 165, 111, 1),
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size(double.infinity, 44),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 100),
//
//                 Center(
//                   child: Text(
//                     'or',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14),
//                   ),
//                 ),
//                 // const Row(
//                 //   children: [
//                 //     // Expanded(child: Divider()),
//                 //     Padding(
//                 //       padding: EdgeInsets.symmetric(horizontal: 16),
//                 //       child: Text(
//                 //         'or',
//                 //         style: TextStyle(
//                 //             color: Colors.grey,
//                 //             fontWeight: FontWeight.w400,
//                 //             fontSize: 14),
//                 //       ),
//                 //     ),
//                 //     // Expanded(child: Divider()),
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 24),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.of(context).pushReplacement(
//                 //       MaterialPageRoute(
//                 //           builder: (context) => RegisterUserScreen()),
//                 //     );
//                 //   },
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Color.fromRGBO(79, 165, 111, 1),
//                 //     foregroundColor: Colors.white,
//                 //     minimumSize: const Size(double.infinity, 50),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(12),
//                 //     ),
//                 //   ),
//                 //   child: const Text(
//                 //     'Register',
//                 //     style: TextStyle(
//                 //       fontSize: 16,
//                 //       fontWeight: FontWeight.w700,
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(height: 100),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Handle Google sign in
//                     },
//                     style: OutlinedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       side: const BorderSide(color: Colors.black),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/google_icon.svg',
//                           // Make sure to add this asset
//                           height: 24,
//                           width: 24,
//                         ),
//                         const SizedBox(width: 12),
//                         const Text(
//                           'Login with Google',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // const SizedBox(height: 60),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: LineWidget(
//                 length: 200,
//                 thickness: 5,
//                 color: const Color.fromRGBO(29, 191, 115, 1),
//                 borderRadius: 12.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
