import 'package:get/get.dart';
import 'package:rakta/controller/bus_view_model.dart';
import 'package:rakta/controller/main_view_model.dart';
import 'package:rakta/controller/payment_controller.dart';

import '../controller/place_view_model.dart';
import '../controller/trip_view_model.dart';
import '../controller/user_view_model.dart';
import '../view/map/home_View_Model.dart';

class GetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainViewModel());
    Get.put(TripViewModel());
    Get.put(UserViewModel());
    Get.put(PlaceViewModel(),);
    Get.put(PaymentController(),);
    Get.put(HomeViewModel());
    Get.put(BusViewModel());
  }
}
