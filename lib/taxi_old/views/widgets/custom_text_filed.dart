// import 'package:flutter/material.dart';
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
//
// class CustomTextFiled extends StatelessWidget {
//   const CustomTextFiled(
//       {super.key,
//       required this.label,
//       required this.hint,
//       this.obscureText = false});
//
//   final String label, hint;
//   final bool obscureText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style:
//               Styles.headLineStyle3.copyWith(fontSize: 14, color: Colors.black),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(
//           height: AppLayout.getHeight(2),
//         ),
//         TextFormField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             isDense: true,
//             hintStyle: Styles.headLineStyle3.copyWith(
//               fontSize: 14,
//             ),
//             suffixIcon: obscureText
//                 ? const Icon(Icons.remove_red_eye_outlined)
//                 : const SizedBox(),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             hintText: hint,
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Colors.black)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
