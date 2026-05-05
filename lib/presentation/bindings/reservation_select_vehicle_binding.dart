import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_select_vehicle_controller.dart';

class ReservationSelectVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationSelectVehicleController>(
      () => ReservationSelectVehicleController(),
    );
  }
}
