import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/auth/login_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/register_controller.dart';

/// Auth binding - registers auth controllers
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
