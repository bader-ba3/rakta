// import 'package:flutter/material.dart';
//
//
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
// import '../widgets/custom_text_filed.dart';
//
// class RestPasswordPage extends StatelessWidget {
//   const RestPasswordPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
//         child: ListView(
//           children: [
//             Center(
//               child: Text(
//                 "New Password",
//                 style: Styles.headLineStyle1.copyWith(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(10),
//             ),
//             Text(
//               "Your new password must be different\n from previously used password",
//               style:
//                   Styles.headLineStyle2.copyWith(fontSize: 14, color: primary),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const CustomTextFiled(
//                 label: "Password", hint: "************", obscureText: true),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const CustomTextFiled(
//                 label: "Confirm Password",
//                 hint: "************",
//                 obscureText: true),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const AppButton(label: "Create New Password")
//           ],
//         ),
//       ),
//     );
//   }
// }
