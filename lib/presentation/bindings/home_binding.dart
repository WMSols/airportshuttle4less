import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';

/// Ensures [HomeController] exists when [HomeScreen] is opened outside [MainBinding].
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(() => HomeController());
    }
  }
}
