// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// import '../../utils/app_style.dart';
// import '../navigation/navigation_page.dart';
// import '../../../view/widgets/animation_circle.dart';
//
// class LoadingPage extends StatelessWidget {
//   const LoadingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Timer(const Duration(seconds: 1), () {
//       Get.to(const NavigationPage());
//     });
//     return Scaffold(
//       backgroundColor: primary,
//       body: Center(
//         child: Stack(
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(10.0),
//               child: AnimationCircle(),
//             ),
//             Positioned(
//                 top: Get.height / 2 + 50,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                     child: Text(
//                   "RAK Taxi Booking",
//                   style: Styles.headLineStyle1.copyWith(color: Colors.white),
//                 )))
//           ],
//         ),
//       ),
//     );
//   }
// }
// // Column(
// // mainAxisAlignment: MainAxisAlignment.center,
// // children: [
// // Container(
// // padding: EdgeInsets.symmetric(
// // vertical: AppLayout.getHeight(15),
// // horizontal: AppLayout.getWidth(15),
// // ),
// // decoration: const BoxDecoration(
// // shape: BoxShape.circle, color: Colors.white),
// // child: Image.asset(
// // "assets/taxi _start_icon.png",
// // height: AppLayout.getHeight(50),
// // width: AppLayout.getWidth(50),
// // color: primary,
// // )),
// // const SizedBox(
// // height: 15,
// // ),
// // Text(
// // "RAK Taxi Booking",
// // style: Styles.headLineStyle2.copyWith(color: Colors.white),
// // )
// // ],
// // )