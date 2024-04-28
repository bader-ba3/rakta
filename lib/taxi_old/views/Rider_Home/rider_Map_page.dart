// // ignore_for_file: file_names
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:rakta/taxi/views/Rider_Home/widget/dest_bottom_sheet.dart';
// import 'package:rakta/taxi/views/Rider_Home/widget/src_bottom_sheet.dart';
//
//
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../Services/services.dart';
// import '../../../controller/trip_view_model.dart';
// import '../../model/trip_model.dart';
// import '../../utils/app_style.dart';
// import '../../../utils/var.dart';
// import 'Rider_home_View_Model.dart';
//
// // ignore: must_be_immutable
// class RiderHomeMapPage extends StatefulWidget {
//   RiderHomeMapPage({super.key, required this.tripModel});
//
//   @override
//   State<RiderHomeMapPage> createState() => _RiderHomeMapPageState();
//   TripModel tripModel;
// }
//
// class _RiderHomeMapPageState extends State<RiderHomeMapPage> {
//   var initialCameraPosition = const CameraPosition(
//     target: Const.locationCompany,
//     zoom: 16,
//   );
//
//   TripStatus cTripStatus = TripStatus.approved;
//
//   @override
//   void initState() {
//     super.initState();
//     Get.find<RiderHomeViewModel>().getLocationUpdates(widget.tripModel);
//   }
//
//   @override
//   void dispose() async {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<RiderHomeViewModel>(builder: (riderHomeViewModel) {
//       return Scaffold(
//         body: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GoogleMap(
//                 myLocationButtonEnabled: false,
//                 mapToolbarEnabled: false,
//                 trafficEnabled: true,
//                 initialCameraPosition: initialCameraPosition,
//                 mapType: MapType.normal,
//                 onMapCreated: (controller) async {
//                   String mapStyle =
//                       await rootBundle.loadString('assets/map_style.json');
//                   controller.setMapStyle(mapStyle);
//                   riderHomeViewModel.controller = Completer();
//                   riderHomeViewModel.controller.complete(controller);
//                   Utils().getMyLocation().then((value) {
//                     riderHomeViewModel.setMarker(value, "car_gry", "myId");
//                     Variables.currentLoc = value;
//                   });
//
//                   riderHomeViewModel
//                       .animateCamera(widget.tripModel.tpSrc!.location!);
//
//                   riderHomeViewModel.setMarker(
//                       widget.tripModel.tpSrc!.location!,
//                       "location_arrow_icon",
//                       "tpSrc");
//                   riderHomeViewModel.setMarker(
//                       widget.tripModel.tpDest!.location!,
//                       "location_pin",
//                       "tpDest");
//                 },
//                 markers: riderHomeViewModel.markers,
//               ),
//             ),
//             Positioned(
//               bottom: 75,
//               right: 10,
//               child: IconButton(
//                 iconSize: 30,
//                 style: ButtonStyle(
//                     shadowColor: MaterialStateProperty.all(Colors.black),
//                     elevation: MaterialStateProperty.all(1),
//                     backgroundColor: MaterialStateProperty.all(Colors.white)),
//                 icon: Icon(
//                   Icons.navigation,
//                   color: primary,
//                 ),
//                 onPressed: () async {
//                   try {
//                     double lat, long;
//                     if (cTripStatus == TripStatus.approved) {
//                       lat = widget.tripModel.tpSrc!.location!.latitude;
//                       long = widget.tripModel.tpSrc!.location!.longitude;
//                     } else {
//                       lat = widget.tripModel.tpDest!.location!.latitude;
//                       long = widget.tripModel.tpDest!.location!.longitude;
//                     }
//                     String googleMapsUrl = 'google.navigation:q=$lat, $long';
//                     String fallbackUrl =
//                         'https://maps.apple.com/?q=$lat, $long';
//                     if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
//                       await launchUrl(Uri.parse(googleMapsUrl));
//                     } else {
//                       await launchUrl(Uri.parse(fallbackUrl));
//                     }
//                   } on Exception catch (e) {
//                     Get.snackbar("Error", e.toString());
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//         bottomSheet: GestureDetector(
//             onTap: () {
//               if (cTripStatus == TripStatus.approved) {
//                 cTripStatus = TripStatus.onTrip;
//                 setState(() {
//                   Get.find<TripViewModel>().editTrip(TripModel(
//                       tpId: widget.tripModel.tpId,
//                       tpStatus: TripStatus.onTrip));
//                 });
//               } else if (cTripStatus == TripStatus.onTrip) {
//                 Get.find<TripViewModel>().editTrip(TripModel(
//                     tpId: widget.tripModel.tpId, tpStatus: TripStatus.passed));
//                 riderHomeViewModel.timerLister!.cancel();
//                 riderHomeViewModel.listener.cancel();
//                 Get.back();
//               }
//             },
//             child: cTripStatus == TripStatus.approved
//                 ? const SrcBottomSheet()
//                 : const DestBottomSheet()),
//       );
//     });
//   }
// }
