import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/home/all_locations_controller.dart';

class AllLocationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllLocationsController>(() => AllLocationsController());
  }
}
