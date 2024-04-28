// // ignore_for_file: file_names
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
// import '../../../Services/polyline_services.dart';
// import '../../../../model/location_model.dart';
// import '../../../Services/services.dart';
// import '../../../model/trip_model.dart';
// import '../../../../utils/var.dart';
//
// class HistoryMapPage extends StatefulWidget {
//   const HistoryMapPage({super.key, required this.tripModel});
//
//   @override
//   State<HistoryMapPage> createState() => _HistoryMapPageState();
//   final TripModel tripModel;
// }
//
// class _HistoryMapPageState extends State<HistoryMapPage> {
//   var initialCameraPosition = const CameraPosition(
//     target: Const.locationCompany,
//     zoom: 16,
//   );
//
//   Completer<GoogleMapController> controller = Completer();
//
//   final Set<Polyline> _polyLines = {};
//   final Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() async {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GoogleMap(
//         myLocationButtonEnabled: false,
//         initialCameraPosition: initialCameraPosition,
//         mapType: MapType.normal,
//         onMapCreated: (controller) async {
//           String mapStyle =
//               await rootBundle.loadString('assets/map_style.json');
//           controller.setMapStyle(mapStyle);
//           this.controller = Completer();
//           this.controller.complete(controller);
//           setMarker(widget.tripModel.tpSrc!.location!, "location_arrow_icon",
//               "userLoc");
//           setMarker(
//               widget.tripModel.tpDest!.location!, "location_icon", "userLoc2");
//           getDrawPolyline(widget.tripModel.tpPolyLine!);
//           animateCamera(widget.tripModel.tpSrc!.location!);
//         },
//         markers: _markers,
//         polylines: _polyLines,
//       ),
//     ));
//   }
//
//   void setMarker(LatLng location, String path, String uID) {
//     Utils()
//         .getBytesFromAsset(path: 'assets/$path.png', width: 150)
//         .then((value) {
//       Marker newMarker = Marker(
//         markerId: MarkerId(uID),
//         icon: BitmapDescriptor.fromBytes(value),
//         position: location,
//         onTap: () {},
//       );
//       _markers.add(
//         newMarker,
//       );
//       setState(() {});
//     });
//   }
//
//   Future<void> getDrawPolyline(List<LocationModel> tpLocation) async {
//     List<LatLng> polylineCoordinates = [];
//     for (var tp in tpLocation) {
//       polylineCoordinates.add(tp.location!);
//     }
//     Polyline polyline =
//         await PolylineService().getdrawPolyline(polylineCoordinates);
//
//     _polyLines.add(polyline);
//
//     setState(() {});
//   }
//
//   Future<void> animateCamera(LatLng location) async {
//     final GoogleMapController controller = await this.controller.future;
//     CameraPosition cameraPosition = CameraPosition(
//       target: location,
//       zoom: 17.00,
//     );
//     // print(
//     //     "animating camera to (lat: ${location.latitude}, long: ${location.longitude})");
//     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }
// }
