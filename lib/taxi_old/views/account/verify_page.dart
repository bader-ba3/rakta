// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
//
// class VerifyCodePage extends StatelessWidget {
//   const VerifyCodePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 "Verify Code",
//                 style: Styles.headLineStyle1.copyWith(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(10),
//             ),
//             Text(
//               "Please enter the code we just send to email",
//               style:
//                   Styles.headLineStyle2.copyWith(fontSize: 14, color: primary),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               "example@gmail.com",
//               style:
//                   Styles.headLineStyle2.copyWith(fontSize: 14, color: primary),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(40),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     height: 55,
//                     width: 55,
//                     child: TextFormField(
//                       style: Styles.textStyle,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(color: Colors.black)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(1),
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 55,
//                     width: 55,
//                     child: TextFormField(
//                       style: Styles.textStyle,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(color: Colors.black)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(1),
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 55,
//                     width: 55,
//                     child: TextFormField(
//                       style: Styles.textStyle,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(color: Colors.black)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(1),
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 55,
//                     width: 55,
//                     child: TextFormField(
//                       style: Styles.textStyle,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(color: Colors.black)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide(color: Colors.grey.shade300),
//                         ),
//                       ),
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(1),
//                         FilteringTextInputFormatter.digitsOnly
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(40),
//             ),
//             Text(
//               "Didn't receive OTP?",
//               style:
//                   Styles.headLineStyle2.copyWith(fontSize: 14, color: primary),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               "Resend Code?",
//               style: Styles.headLineStyle2.copyWith(
//                   fontSize: 14,
//                   color: Colors.black,
//                   decoration: TextDecoration.underline),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(40),
//             ),
//             const AppButton(label: "Verify"),
//           ],
//         ),
//       ),
//     );
//   }
// }
