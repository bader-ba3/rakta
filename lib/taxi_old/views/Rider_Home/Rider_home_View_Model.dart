// // ignore_for_file: file_names
//
// import 'dart:async';
//
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
//
//
// import '../../Services/polyline_services.dart';
// import '../../Services/services.dart';
// import '../../../controller/trip_view_model.dart';
// import '../../controllers/user_view_model.dart';
// import '../../model/trip_model.dart';
//
// class RiderHomeViewModel extends GetxController {
//   Completer<GoogleMapController> controller = Completer();
//   Set<Marker> markers = {};
//   UserViewModel userViewModel = Get.find<UserViewModel>();
//   TripViewModel tripViewModel = Get.find<TripViewModel>();
//
//   TripStatus? get currentTrip => tripViewModel.currentTrip.tpStatus;
//
//   String? get riderId => tripViewModel.currentTrip.tpRider;
//
//   final Set<Polyline> _polyLines = {};
//
//   Set<Polyline> get polyLines => _polyLines;
//
//   dynamic listener;
//   Timer? timerLister;
//   List<LatLng> currentP = [];
//
//   Future<void> getLocationUpdates(TripModel tripModel) async {
//     currentP = [];
//     Utils().checkLocationPermission().then((value) {
//       if (value == true) {
//         listener =
//             Location().onLocationChanged.listen((LocationData currentLocation) {
//           if (currentLocation.latitude != null &&
//               currentLocation.longitude != null) {
//             currentP.add(
//                 LatLng(currentLocation.latitude!, currentLocation.longitude!));
//             Timer.periodic(const Duration(seconds: 10), (timer) {
//               timerLister = timer;
//               animateCamera(currentP.first);
//               sendLocationToTrip(currentP, tripModel);
//               currentP.clear();
//             });
//             update();
//             listener.cancel();
//           }
//         });
//       }
//     });
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
//       markers.add(
//         newMarker,
//       );
//       update();
//     });
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
//
//   sendLocationToTrip(List<LatLng> location, TripModel tripModel) async {
//     await tripViewModel.sendLocationToTrip(location, tripModel);
//   }
//
//   Future<void> getDrawPolyline(List<LatLng> polylineCoordinates) async {
//     Polyline polyline =
//         await PolylineService().getdrawPolyline(polylineCoordinates);
//     _polyLines.add(polyline);
//     update();
//   }
// }
