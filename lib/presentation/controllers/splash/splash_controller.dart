import 'package:get/get.dart';

import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class SplashController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  Future<void> navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final onboardingDone = await _authUseCase.isOnboardingCompleted();
      final loggedIn = await _authUseCase.isLoggedIn();

      if (!onboardingDone) {
        Get.offAllNamed(AppRoutes.onboarding);
      } else if (!loggedIn) {
        Get.offAllNamed(AppRoutes.selectRole);
      } else {
        await _authUseCase.getCurrentUser();
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (_) {
      // Keep startup stable if local storage state is corrupted on device.
      Get.offAllNamed(AppRoutes.selectRole);
    }
  }
}
