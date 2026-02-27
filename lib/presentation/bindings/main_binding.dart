import 'package:get/get.dart';
import '../controllers/main/main_controller.dart';

/// Main binding - registers all tab controllers
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
