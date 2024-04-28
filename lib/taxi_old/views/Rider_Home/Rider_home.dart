// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../../Services/location_services.dart';
// import '../../../controller/trip_view_model.dart';
// import '../../../model/location_model.dart';
// import '../../model/trip_model.dart';
// import '../../utils/app_style.dart';
// import '../../../utils/var.dart';
//
//
//
// class HomeRiderPage extends StatefulWidget {
//   const HomeRiderPage({super.key});
//
//   @override
//   State<HomeRiderPage> createState() => _HomeRiderPageState();
// }
//
// class _HomeRiderPageState extends State<HomeRiderPage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: GetBuilder<TripViewModel>(builder: (tripController) {
//           return tripController.tripMap.values
//                   .where((element) => element.tpStatus == TripStatus.waiting)
//                   .isNotEmpty
//               ? ListView.builder(
//                   itemCount: tripController.tripMap.values
//                       .where(
//                           (element) => element.tpStatus == TripStatus.waiting)
//                       .length,
//                   itemBuilder: (BuildContext context, int index) {
//                     TripModel trip = tripController.tripMap.values
//                         .where(
//                             (element) => element.tpStatus == TripStatus.waiting)
//                         .elementAt(index);
//                     return ListTile(
//                       title: Text(
//                         trip.tpId.toString(),
//                         style: Styles.headLineStyle4,
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Trip Source: ${trip.tpSrc!.location}",
//                             maxLines: 1,
//                           ),
//                           Text(
//                             "Trip Destination ${trip.tpDest!.location}",
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                       trailing: GestureDetector(
//                         onTap: () async {
//                           LocationService().getLocation().then((value) async {
//                             await tripController.acceptTrip(
//                               TripModel(
//                                   tpId: trip.tpId,
//                                   tpRider: Variables.currentUser.userId,
//                                   tpLocation: [
//                                     LocationModel(
//                                       location: /* const LatLng(
//                                   37.33430996139864, -122.0322162901144),*/
//                                           LatLng(value.latitude!,
//                                               value.longitude!),
//                                     ),
//                                   ],
//                                   tpStatus: TripStatus.approved),
//                             );
//                             // Get.to(RiderHomeMapPage(
//                             //     tripModel: TripModel(
//                             //   tpId: trip.tpId,
//                             //   tpRider: Variables.currentUser.userId,
//                             //   tpSrc: trip.tpSrc,
//                             //   tpDest: trip.tpDest,
//                             //   tpLocation: [
//                             //     LocationModel(
//                             //       location: /* const LatLng(
//                             //     37.33430996139864, -122.0322162901144),*/
//                             //           LatLng(value.latitude!, value.longitude!),
//                             //     )
//                             //   ],
//                             // )));
//                           });
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: primary,
//                           ),
//                           child: const Icon(
//                             Icons.check,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Image.asset("assets/taxi.png"),
//                     ),
//                     Text(
//                       "No Taxi Request Yet ",
//                       style: Styles.headLineStyle1,
//                     )
//                   ],
//                 );
//         }),
//       ),
//     );
//   }
// }
