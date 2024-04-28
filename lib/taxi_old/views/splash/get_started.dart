// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
//
// class GetStarted extends StatelessWidget {
//   const GetStarted({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         height: Get.height,
//         width: Get.width,
//         child: Stack(
//           children: [
//             Container(
//               height: Get.height / 1.5,
//               width: Get.width,
//               decoration: const BoxDecoration(),
//               child: Stack(
//                 children: [
//                   CustomPaint(
//                     foregroundPainter: CirclePainter(),
//                     child: Container(
//                         // color: const Color(0xffF6F6F6),
//                         ),
//                   ),
//                   Positioned(
//                     left: Get.width * 1 / 6,
//                     top: Get.height * 1 / 6,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: AppLayout.getHeight(8),
//                           horizontal: AppLayout.getWidth(8)),
//                       decoration: const BoxDecoration(
//                           color: Colors.white, shape: BoxShape.circle),
//                       child: Icon(
//                         size: 24,
//                         Icons.location_on_sharp,
//                         color: primary,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: Get.width * 1 / 6,
//                     top: Get.height * 1 / 6,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: AppLayout.getHeight(8),
//                           horizontal: AppLayout.getWidth(8)),
//                       decoration: const BoxDecoration(
//                           color: Colors.white, shape: BoxShape.circle),
//                       child: Icon(
//                         size: 24,
//                         Icons.local_police,
//                         color: primary,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 25,
//                     top: Get.height * 1 / 3,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: AppLayout.getHeight(8),
//                           horizontal: AppLayout.getWidth(8)),
//                       decoration: const BoxDecoration(
//                           color: Colors.white, shape: BoxShape.circle),
//                       child: Icon(
//                         size: 24,
//                         Icons.message_outlined,
//                         color: primary,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 25,
//                     top: Get.height * 1 / 3,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: AppLayout.getHeight(8),
//                           horizontal: AppLayout.getWidth(8)),
//                       decoration: const BoxDecoration(
//                           color: Colors.white, shape: BoxShape.circle),
//                       child: Icon(
//                         size: 24,
//                         Icons.phone,
//                         color: primary,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//                 top: Get.height / 1.6,
//                 left: 25,
//                 right: 25,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Welcome to Your ",
//                           style: Styles.textStyle
//                               .copyWith(color: Colors.black, fontSize: 24),
//                         ),
//                         Text(
//                           "Ultimate ",
//                           style: Styles.textStyle
//                               .copyWith(color: primary, fontSize: 24),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "Transportation Solution",
//                       style: Styles.textStyle
//                           .copyWith(color: primary, fontSize: 24),
//                     ),
//                     SizedBox(
//                       height: AppLayout.getHeight(25),
//                     ),
//                     Text(
//                       "lorem ipsum dolor sit amet, consecrate \n adipiscing elit, sed do eiusmod tempor incididunt",
//                       style: Styles.headLineStyle2.copyWith(
//                         fontSize: 14,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: AppLayout.getHeight(25),
//                     ),
//                     const AppButton(label: "Let's Get Started"),
//                     SizedBox(
//                       height: AppLayout.getHeight(25),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already have an account? ",
//                           style: Styles.headLineStyle2.copyWith(
//                             fontSize: 18,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           "Sign in",
//                           style: Styles.headLineStyle2.copyWith(
//                               fontSize: 18,
//                               color: primary,
//                               decoration: TextDecoration.underline),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height - 550);
//
//     final paint = Paint()
//       ..color = const Color(0xffF6F6F6)
//       ..strokeWidth = 10
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(
//       center,
//       500,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
