import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/home/all_services_controller.dart';

class AllServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllServicesController>(() => AllServicesController());
  }
}
