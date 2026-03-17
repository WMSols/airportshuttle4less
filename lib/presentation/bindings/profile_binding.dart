import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/profile/edit_profile_controller.dart';

/// Binding for profile-related screens (e.g. Edit Profile).
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}
