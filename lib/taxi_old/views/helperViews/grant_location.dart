// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
//
// class GrantLocationPage extends StatelessWidget {
//   const GrantLocationPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: AppLayout.getHeight(15),
//                   horizontal: AppLayout.getWidth(15),
//                 ),
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle, color: Colors.grey.shade300),
//                 child: Image.asset(
//                   "assets/location_icon.png",
//                   height: AppLayout.getHeight(50),
//                   width: AppLayout.getWidth(50),
//                   color: primary,
//                 )),
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               "Enable Location Access",
//               style: Styles.headLineStyle1.copyWith(color: Colors.black),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
//               child: Text(
//                 "To ensure seamless and efficient experience, allow us\naccess to your location.",
//                 style: Styles.headLineStyle4
//                     .copyWith(color: primary, fontSize: 13),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: Get.width,
//         height: Get.height * 1 / 5,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//             boxShadow: [BoxShadow(color: primary, blurRadius: 5)]),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Column(
//             children: [
//               const AppButton(label: "Allow Location Access"),
//               const Spacer(),
//               Text(
//                 "Maybe Later",
//                 style: Styles.headLineStyle3
//                     .copyWith(color: primary, fontSize: 18),
//               ),
//               const Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
