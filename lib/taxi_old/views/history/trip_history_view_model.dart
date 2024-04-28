import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Services/services.dart';

class TripHistoryViewModel extends GetxController {
  Completer<GoogleMapController> controller = Completer();
  Set<Marker> markers = {};

  void setMarker(LatLng location, String path, String uID) {
    Utils()
        .getBytesFromAsset(path: 'assets/$path.png', width: 150)
        .then((value) {
      Marker newMarker = Marker(
        markerId: MarkerId(uID),
        icon: BitmapDescriptor.fromBytes(value),
        position: location,
        onTap: () {},
      );
      markers.add(
        newMarker,
      );
      update();
    });
  }

  Future<void> animateCamera(LatLng location) async {
    final GoogleMapController controller = await this.controller.future;
    CameraPosition cameraPosition = CameraPosition(
      target: location,
      zoom: 17.00,
    );
    // print(
    //     "animating camera to (lat: ${location.latitude}, long: ${location.longitude})");
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
