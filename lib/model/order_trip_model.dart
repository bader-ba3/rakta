import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersTripModel {
  String? fromAddress , toAddress , status , userName,userNumber ;
  LatLng? fromLatLng , toLatLng;
  double? total ;
  OrdersTripModel.fromJson(json){
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    status = json['status'];
    total = json['total']??0;
    userName = json['userName'];
    userNumber = json['userNumber'];
    fromLatLng = LatLng(json['fromLatLng']['lat'], json['fromLatLng']['lng']);
    toLatLng = LatLng(json['toLatLng']['lat'], json['toLatLng']['lng']);
  }
}