import 'package:get/get.dart';

import 'package:airportshuttle4less/domain/entities/user.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for profile screen. Loads current user and handles logout.
class ProfileController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final Rx<User?> user = Rx<User?>(null);
  final isLoading = true.obs;
  final isLoggingOut = false.obs;

  @override
  void onReady() {
    super.onReady();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    try {
      final currentUser = await _authUseCase.getCurrentUser();
      user.value = currentUser;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoggingOut.value = true;
    try {
      await _authUseCase.logout();
      Get.offAllNamed(AppRoutes.login);
    } finally {
      isLoggingOut.value = false;
    }
  }

  void navigateToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  void navigateToForgotPassword(String email) {
    Get.toNamed(AppRoutes.forgotPassword, arguments: {'email': email});
  }

  void navigateToFaqs() {
    Get.toNamed(AppRoutes.faqs);
  }

  void navigateToContactUs() {
    Get.toNamed(AppRoutes.contactUs);
  }

  void navigateToCorporateQuote() {
    Get.toNamed(AppRoutes.corporateQuote);
  }

  void navigateToTerms() {
    Get.toNamed(AppRoutes.terms);
  }

  void navigateToPrivacy() {
    Get.toNamed(AppRoutes.privacy);
  }

  void navigateToReviews() {
    Get.toNamed(AppRoutes.reviews);
  }
}
