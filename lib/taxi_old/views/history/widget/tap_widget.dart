// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// import '../../../Services/polyline_services.dart';
// import '../../../../controller/trip_view_model.dart';
// import '../../../controllers/user_view_model.dart';
// import '../../../model/trip_model.dart';
// import '../../../utils/app_style.dart';
// import '../../../../utils/var.dart';
// import 'history_map_View.dart';
//
// // ignore: must_be_immutable
// class TapWidget extends StatelessWidget {
//   TapWidget({super.key, required this.tapIndex});
//
//   int tapIndex;
//   UserViewModel userViewModel = Get.find<UserViewModel>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TripViewModel>(builder: (tripController) {
//       return ListView.builder(
//         itemCount: tripController.tripMap.values.where((element) {
//           if (tapIndex == 0) {
//             return element.tpStatus == TripStatus.onTrip ||
//                 element.tpStatus == TripStatus.approved ||
//                 element.tpStatus == TripStatus.waiting &&
//                     (element.tpUser == Variables.currentUser.userId ||
//                         element.tpRider == Variables.currentUser.userId);
//           } else if (tapIndex == 1) {
//             return element.tpStatus == TripStatus.passed &&
//                 (element.tpUser == Variables.currentUser.userId ||
//                     element.tpRider == Variables.currentUser.userId);
//           } else {
//             return element.tpStatus == TripStatus.canceled &&
//                 (element.tpUser == Variables.currentUser.userId ||
//                     element.tpRider == Variables.currentUser.userId);
//           }
//         }).length,
//         itemBuilder: (BuildContext context, int index) {
//           TripModel trip = tripController.tripMap.values.where((element) {
//             if (tapIndex == 0) {
//               return element.tpStatus == TripStatus.onTrip ||
//                   element.tpStatus == TripStatus.approved ||
//                   element.tpStatus == TripStatus.waiting &&
//                       (element.tpUser == Variables.currentUser.userId ||
//                           element.tpRider == Variables.currentUser.userId);
//             } else if (tapIndex == 1) {
//               return element.tpStatus == TripStatus.passed &&
//                   (element.tpUser == Variables.currentUser.userId ||
//                       element.tpRider == Variables.currentUser.userId);
//             } else {
//               return element.tpStatus == TripStatus.canceled &&
//                   (element.tpUser == Variables.currentUser.userId ||
//                       element.tpRider == Variables.currentUser.userId);
//             }
//           }).elementAt(index);
//           double tpDest = double.parse(PolylineService()
//               .calcDistance(trip.tpPolyLine!.map((e) => e.location!).toList()));
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(color: primary.withOpacity(0.3), blurRadius: 5)
//                     ],
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 100,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 65,
//                               width: 65,
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: primary.withOpacity(0.3),
//                                   image: DecorationImage(
//                                       image: NetworkImage(userViewModel
//                                           .userMap[trip.tpRider]!.userImage
//                                           .toString()),
//                                       fit: BoxFit.cover)),
//                             ),
//                             const SizedBox(
//                               width: 8,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   userViewModel.userMap[trip.tpRider]!.userName
//                                       .toString(),
//                                   style: Styles.textStyle,
//                                 ),
//                                 Text(
//                                   userViewModel.userMap[trip.tpRider]!.userCar
//                                       .toString(),
//                                   style: Styles.headLineStyle3,
//                                 )
//                               ],
//                             ),
//                             const Spacer(),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.star_rounded,
//                                   color: primary,
//                                 ),
//                                 Text(
//                                   "5.0",
//                                   style: Styles.textStyle,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       Divider(
//                         color: primary.withOpacity(0.3),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           TextIconWidget(
//                             icon: Icons.location_on_outlined,
//                             text: "$tpDest KM",
//                           ),
//                           const Spacer(),
//                           TextIconWidget(
//                             icon: Icons.access_time_outlined,
//                             text: "${(tpDest).round() * 2} Min's",
//                           ),
//                           const Spacer(),
//                           TextIconWidget(
//                             icon: Icons.credit_card_outlined,
//                             text: "\$ ${((tpDest) * 5).floor()}",
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "  Date & Time",
//                             style: Styles.headLineStyle4,
//                           ),
//                           const Spacer(),
//                           Text(
//                             trip.tpDate.toString(),
//                             style: Styles.headLineStyle4
//                                 .copyWith(color: Colors.black),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Divider(
//                         color: primary.withOpacity(0.3),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       SizedBox(
//                         height: 70,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 const Icon(
//                                   Icons.share_location_outlined,
//                                   color: Colors.black,
//                                 ),
//                                 Container(
//                                   height: 5,
//                                   color: primary,
//                                   width: 1,
//                                 ),
//                                 const Spacer(),
//                                 Container(
//                                   height: 5,
//                                   color: primary,
//                                   width: 1,
//                                 ),
//                                 const Spacer(),
//                                 Container(
//                                   height: 5,
//                                   color: primary,
//                                   width: 1,
//                                 ),
//                                 const Spacer(),
//                                 Container(
//                                   height: 5,
//                                   color: primary,
//                                   width: 1,
//                                 ),
//                                 Icon(
//                                   Icons.location_on_outlined,
//                                   color: primary,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     trip.tpSrc!.locName.toString(),
//                                     style: Styles.textStyle,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const Spacer(),
//                                   Divider(
//                                     color: primary.withOpacity(0.3),
//                                   ),
//                                   const Spacer(),
//                                   Text(
//                                     trip.tpDest!.locName.toString(),
//                                     style: Styles.textStyle,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Divider(
//                         color: primary.withOpacity(0.3),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Trip Number",
//                             style: Styles.headLineStyle4,
//                           ),
//                           const Spacer(),
//                           Text(
//                             trip.tpId.toString(),
//                             style: Styles.headLineStyle4
//                                 .copyWith(color: Colors.black),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(HistoryMapPage(tripModel: trip));
//                         },
//                         child: const Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Spacer(),
//                             Icon(
//                               Icons.keyboard_arrow_up_outlined,
//                               size: 26,
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
// }
//
// class TextIconWidget extends StatelessWidget {
//   const TextIconWidget({super.key, required this.text, required this.icon});
//
//   final String text;
//   final IconData icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: primary,
//         ),
//         const SizedBox(
//           width: 5,
//         ),
//         Text(
//           text,
//           style: Styles.textStyle.copyWith(fontSize: 14),
//         )
//       ],
//     );
//   }
// }
