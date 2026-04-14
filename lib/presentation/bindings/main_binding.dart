import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/main/main_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/main/main_navigation_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/profile_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Main binding - registers all tab controllers
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(() => HomeController());
    }
    Get.lazyPut<MainNavigationController>(() => MainNavigationController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ReservationFlowController>(() => ReservationFlowController());
    Get.lazyPut<ReservationRideInfoController>(
      () => ReservationRideInfoController(),
    );
  }
}
