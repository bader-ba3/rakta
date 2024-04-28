// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
//
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
// import '../widgets/custom_text_filed.dart';
//
// class LogIn extends StatelessWidget {
//   const LogIn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
//         child: ListView(
//           children: [
//             Center(
//               child: Text(
//                 "Sign In",
//                 style: Styles.headLineStyle1.copyWith(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(10),
//             ),
//             Text(
//               "Hi! Welcome back,you've been missed",
//               style:
//                   Styles.headLineStyle2.copyWith(fontSize: 14, color: primary),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(15),
//             ),
//             const CustomTextFiled(
//               label: "Email",
//               hint: "example@gmail.com",
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(15),
//             ),
//             const CustomTextFiled(
//                 label: "Password", hint: "**********", obscureText: true),
//             SizedBox(
//               height: AppLayout.getHeight(15),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 "Forgot Password?",
//                 style: Styles.headLineStyle2.copyWith(
//                     fontSize: 14,
//                     color: primary,
//                     decoration: TextDecoration.underline),
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const AppButton(label: "Sign In"),
//             SizedBox(
//               height: AppLayout.getHeight(35),
//             ),
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: AppLayout.getWidth(40),
//                         vertical: AppLayout.getHeight(15)),
//                     child: Container(
//                       height: 1,
//                       width: Get.width,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     height: AppLayout.getHeight(30),
//                     width: AppLayout.getWidth(100),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Center(
//                       child: Text(
//                         'Or sign in with',
//                         style: Styles.textStyle
//                             .copyWith(color: primary, fontSize: 14),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             Row(
//               children: [
//                 const Spacer(),
//                 Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: AppLayout.getHeight(15),
//                       horizontal: AppLayout.getWidth(15),
//                     ),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: primary.withOpacity(0.3))),
//                     child: Image.asset(
//                       "assets/apple_logo.png",
//                       height: AppLayout.getHeight(30),
//                       width: AppLayout.getWidth(30),
//                       color: Colors.black,
//                     )),
//                 SizedBox(
//                   width: AppLayout.getWidth(10),
//                 ),
//                 Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: AppLayout.getHeight(15),
//                       horizontal: AppLayout.getWidth(15),
//                     ),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: primary.withOpacity(0.3))),
//                     child: Image.asset(
//                       "assets/google_logo.png",
//                       height: AppLayout.getHeight(30),
//                       width: AppLayout.getWidth(30),
//                     )),
//                 SizedBox(
//                   width: AppLayout.getWidth(10),
//                 ),
//                 Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: AppLayout.getHeight(15),
//                       horizontal: AppLayout.getWidth(15),
//                     ),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                         border: Border.all(color: primary.withOpacity(0.3))),
//                     child: Image.asset(
//                       "assets/facebook_logo.png",
//                       height: AppLayout.getHeight(30),
//                       width: AppLayout.getWidth(30),
//                       color: Colors.grey,
//                     )),
//                 const Spacer(),
//               ],
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(40),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Already have an account? ",
//                   style: Styles.headLineStyle2.copyWith(
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: primary,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Sign in",
//                     style: Styles.headLineStyle2.copyWith(
//                       fontSize: 14,
//                       color: primary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
