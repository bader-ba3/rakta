// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rakta/taxi/views/splash/widget/first_onboarding.dart';
// import 'package:rakta/taxi/views/splash/widget/second_onboarding.dart';
// import 'package:rakta/taxi/views/splash/widget/third_onboarding.dart';
//
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import 'get_started.dart';
//
// class OnBoarding extends StatefulWidget {
//   const OnBoarding({super.key});
//
//   @override
//   State<OnBoarding> createState() => _OnBoardingState();
// }
//
// class _OnBoardingState extends State<OnBoarding> {
//   int position = 0;
//   PageController controller = PageController(initialPage: 0);
//   List<Widget> onBoarding = [
//     const FirstOnboarding(),
//     const SecondOnboarding(),
//     const ThirdOnboarding(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//   }
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
//               child: CustomPaint(
//                 painter: CirclePainter(),
//                 child: Center(
//                   child: AnimatedOpacity(
//                     duration: const Duration(milliseconds: 500),
//                     opacity: 1,
//                     child: Image.asset(
//                       "assets/on_boarding/onboarding_$position.png",
//                       height: Get.height * 1 / 3,
//                       width: Get.width / 2,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: Get.height / 1.6,
//                 left: 25,
//                 right: 25,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: AppLayout.getHeight(25),
//                     ),
//                     SizedBox(
//                       height: Get.height * 1 / 5,
//                       child: PageView(
//                           onPageChanged: (s) {
//                             position = s;
//                             setState(() {});
//                           },
//                           controller: controller,
//                           children: onBoarding),
//                     ),
//                     SizedBox(
//                       height: AppLayout.getHeight(25),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             if (position > 0) {
//                               setState(() {
//                                 position--;
//                                 controller.animateToPage(position,
//                                     duration: const Duration(milliseconds: 500),
//                                     curve: Curves.linear);
//                               });
//                             }
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                                 border: Border.all(
//                                   color: position == 0 ? Colors.white : primary,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Icon(
//                                   Icons.arrow_back,
//                                   color: position == 0 ? Colors.white : primary,
//                                 ),
//                               )),
//                         ),
//                         DotsIndicator(
//                           dotsCount: 3,
//                           position: position,
//                           onTap: (position) {
//                             this.position = position;
//                             controller.animateToPage(position,
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.linear);
//                             setState(() {});
//                           },
//                           decorator: DotsDecorator(
//                               color: Colors.grey.shade300,
//                               activeColor: primary,
//                               activeSize: const Size(13, 13)),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if (position < 2) {
//                               setState(() {
//                                 position++;
//                                 controller.animateToPage(position,
//                                     duration: const Duration(milliseconds: 500),
//                                     curve: Curves.linear);
//                               });
//                             }
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: primary,
//                               ),
//                               child: const Center(
//                                 child: Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                 ),
//                               )),
//                         ),
//                       ],
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
