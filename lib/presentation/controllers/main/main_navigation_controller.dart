import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

/// Bridges [PersistentTabController] to GetX so child tabs (e.g. Home) can switch tabs.
class MainNavigationController extends GetxController {
  PersistentTabController? _tabController;

  void attach(PersistentTabController controller) {
    _tabController = controller;
  }

  void detach() {
    _tabController = null;
  }

  void jumpToTab(int index) {
    _tabController?.jumpToTab(index);
  }

  @override
  void onClose() {
    _tabController = null;
    super.onClose();
  }
}
