import 'package:get/get.dart';
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
    Get.lazyPut(() => HomeViewModel(),fenix: true);
    // Get.lazyPut(() => RiderHomeViewModel(),fenix: true);
    // Get.lazyPut(() => TripHistoryViewModel(),fenix: true);
    Get.put(PlaceViewModel(),);
    Get.put(PaymentController(),);
  }
}
