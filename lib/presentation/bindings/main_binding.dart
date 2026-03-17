import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/main/main_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/profile_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';

/// Main binding - registers all tab controllers
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ReservationController>(() => ReservationController());
    Get.lazyPut<ReservationFlowController>(() => ReservationFlowController());
  }
}
