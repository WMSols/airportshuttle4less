import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_payment_info_controller.dart';

class ReservationPaymentInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationPaymentInfoController>(
      () => ReservationPaymentInfoController(),
    );
  }
}
