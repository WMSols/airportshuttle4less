import 'package:get/get.dart';

/// Main controller for bottom navigation
class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
