//
//
// import 'package:flutter/material.dart';
//
// import '../../../utils/app_layout.dart';
// import '../../../utils/app_style.dart';
//
// class ThirdOnboarding extends StatelessWidget {
//   const ThirdOnboarding({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Elevated Your ",
//               style:
//               Styles.textStyle.copyWith(color: Colors.black, fontSize: 24),
//             ),
//             Text(
//               "Ride Tracking ",
//               style: Styles.textStyle.copyWith(color: primary, fontSize: 24),
//             ),
//           ],
//         ),
//         Text(
//           "Experience",
//           style: Styles.textStyle.copyWith(color: primary, fontSize: 24),
//         ),
//         SizedBox(
//           height: AppLayout.getHeight(25),
//         ),
//         Text(
//           "lorem ipsum dolor sit amet, consecrate \n adipiscing elit, sed do eiusmod tempor incididunt",
//           style: Styles.headLineStyle2.copyWith(
//             fontSize: 14,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(
//           height: AppLayout.getHeight(25),
//         ),
//       ],
//     );
//   }
// }