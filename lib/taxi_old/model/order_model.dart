


// import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/var.dart';
import '../../model/location_model.dart';

class OrderModel {
  String? ordId, ordUser;
  OrderState? ordState;
  // LatLng? ordUserLocation;
  LocationModel? ordUserLocation, shippingLocation;

  OrderModel({
    this.ordId,
    this.ordUser,
    this.ordUserLocation,
    this.shippingLocation,
    this.ordState,
  });
  OrderModel.fromJson(Map<String, dynamic> map) {
    ordId = map['ordId'] ?? '';
    ordUser = map['ordUser'] ?? '';
    ordUserLocation = LocationModel.fromJson(map['ordUserLocation'] ?? {});
    shippingLocation = LocationModel.fromJson(map["shippingLocation"] ?? {});
    ordState = orderStatefromString(
        map['ordState'] ?? "OrderState.deliveryIsInProgress");
  }

  toJson() {
    return {
      if (ordId != null) "ordId": ordId,
      if (ordUser != null) "ordUser": ordUser,
      if (ordUserLocation != null) "ordUserLocation": ordUserLocation!.toJson(),
      if (shippingLocation != null)
        "shippingLocation": shippingLocation!.toJson(),
      if (ordState != null) "ordState": ordState.toString(),
    };
  }
}

OrderState orderStatefromString(String orderState) {
  switch (orderState) {
    case "OrderState.processing":
      return OrderState.processing;
    case "OrderState.deliveryIsInProgress":
      return OrderState.deliveryIsInProgress;
    case "OrderState.delivered":
      return OrderState.delivered;
    case "OrderState.cancelled":
      return OrderState.cancelled;
  }
  return OrderState.processing;
}
