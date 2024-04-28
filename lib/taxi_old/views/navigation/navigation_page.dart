// import 'package:flutter/material.dart';
//
//
// import 'package:showcaseview/showcaseview.dart';
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../Rider_Home/Rider_home.dart';
// import '../history/trip_history.dart';
// import '../home/home_map.dart';
// import '../setting/profile_Setting_page.dart';
//
// class NavigationPage extends StatefulWidget {
//   const NavigationPage({super.key});
//
//   @override
//   State<NavigationPage> createState() => _NavigationPageState();
// }
//
// class _NavigationPageState extends State<NavigationPage> {
//   int selectedIndex = 0;
//
//   List<GlobalKey<State<StatefulWidget>>> keys =
//       List.generate(6, (index) => GlobalKey());
//
//   BuildContext? myContext;
//
//   @override
//   void initState() {
//     super.initState();
//   /*  Future.delayed(const Duration(seconds: 1), () {
//       WidgetsBinding.instance.addPostFrameCallback((_) =>
//           ShowCaseWidget.of(myContext!).startShowCase(
//               keys));
//       setState(() {});
//     });*/
//   }
//
//   late final List<Widget> _widgetOptions = <Widget>[
//
//     const HomeRiderPage(),
//     // Container(),
//     const TripHistory(),
//     // Container(),
//     const ProfileSettingPage(),
//   ];
//
//   onItemTapped(int index) {
//     selectedIndex = index;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: ShowCaseWidget(
//         builder: Builder(
//           builder: (context) {
//             myContext=context;
//             return Scaffold(
//               backgroundColor: Colors.black,
//               extendBody: true,
//               body: _widgetOptions[selectedIndex],
//               bottomNavigationBar: BottomNavigationBar(
//                 onTap: onItemTapped,
//                 currentIndex: selectedIndex,
//                 elevation: 10,
//                 type: BottomNavigationBarType.fixed,
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 items: [
//                   BottomNavigationBarItem(
//                       icon:  Showcase(
//                         key: keys[2],
//
//                         movingAnimationDuration: Durations.short1,
//                         description: "This tap for home page",
//                         tooltipPadding: const EdgeInsets.all(15),
//                         showArrow: true,
//                         blurValue: 10,
//                         targetBorderRadius: BorderRadius.circular(5),
//                         targetPadding: const EdgeInsets.all(10),
//                         targetShapeBorder: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Image.asset(
//                               "assets/home_icon.png",
//                               height: AppLayout.getHeight(26),
//                               width: AppLayout.getWidth(26),
//                               color: primary,
//                             ),
//                             Positioned(
//                               top: -15,
//                               left: 05,
//                               right: 05,
//                               child: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 300),
//                                 opacity: selectedIndex == 0 ? 1 : 0,
//                                 child: Container(
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10)),
//                                       color: blueRak),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       label: "Home"),
//                   BottomNavigationBarItem(
//                       icon: Showcase(
//                         key: keys[3],
//                         movingAnimationDuration: Durations.short1,
//                         description: "This tap for wallet page",
//                         tooltipPadding: const EdgeInsets.all(15),
//                         showArrow: true,
//                         blurValue: 10,
//                         targetBorderRadius: BorderRadius.circular(5),
//                         targetPadding: const EdgeInsets.all(10),
//                         targetShapeBorder: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Image.asset(
//                               "assets/wallet_icon.png",
//                               height: AppLayout.getHeight(26),
//                               width: AppLayout.getWidth(26),
//                               color: primary,
//                             ),
//                             Positioned(
//                               top: -15,
//                               left: 05,
//                               right: 05,
//                               child: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 300),
//                                 opacity: selectedIndex == 1 ? 1 : 0,
//                                 child: Container(
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10)),
//                                       color: blueRak),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       // activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
//                       label: "Home"),
//                   BottomNavigationBarItem(
//                       icon: Showcase(
//                         key: keys[4],
//                         movingAnimationDuration: Durations.short1,
//                         description: "This tap for trips history",
//                         tooltipPadding: const EdgeInsets.all(15),
//                         showArrow: true,
//                         blurValue: 10,
//                         targetBorderRadius: BorderRadius.circular(5),
//                         targetPadding: const EdgeInsets.all(10),
//                         targetShapeBorder: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Image.asset(
//                               "assets/calender_icon.png",
//                               height: AppLayout.getHeight(26),
//                               width: AppLayout.getWidth(26),
//                               color: primary,
//                             ),
//                             Positioned(
//                               top: -15,
//                               left: 05,
//                               right: 05,
//                               child: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 300),
//                                 opacity: selectedIndex == 2 ? 1 : 0,
//                                 child: Container(
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10)),
//                                       color: blueRak),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       // activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
//                       label: "Home"),
//                   /*        BottomNavigationBarItem(
//                   icon: Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       Image.asset(
//                         "assets/message_icon.png",
//                         height: AppLayout.getHeight(26),
//                         width: AppLayout.getWidth(26),
//                         color: primary,
//                       ),
//                       Positioned(
//                         top: -15,
//                         left: 05,
//                         right: 05,
//                         child: AnimatedOpacity(
//                           duration: const Duration(milliseconds: 300),
//                           opacity: selectedIndex == 3 ? 1 : 0,
//                           child: Container(
//                             height: 8,
//                             decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.only(
//                                     bottomRight: Radius.circular(10),
//                                     bottomLeft: Radius.circular(10)),
//                                 color: primary),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   // activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
//                   label: "Home"),*/
//                   BottomNavigationBarItem(
//                       icon: Showcase(
//                         key: keys[5],
//
//                         movingAnimationDuration: Durations.short1,
//                         description: "This tap for profile",
//                         tooltipPadding: const EdgeInsets.all(15),
//                         showArrow: true,
//                         blurValue: 10,
//                         targetBorderRadius: BorderRadius.circular(5),
//                         targetPadding: const EdgeInsets.all(10),
//                         targetShapeBorder: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15)),
//                         child:Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Image.asset(
//                               "assets/person.png",
//                               height: AppLayout.getHeight(26),
//                               width: AppLayout.getWidth(26),
//                               color: primary,
//                             ),
//                             Positioned(
//                               top: -15,
//                               left: 05,
//                               right: 05,
//                               child: AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 300),
//                                 opacity: selectedIndex == 3 ? 1 : 0,
//                                 child: Container(
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                       borderRadius: const BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10)),
//                                       color: blueRak),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       // activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
//                       label: "Home"),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
