import 'package:get/get.dart';

import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

/// Controller for Leave Review form: submit via SaveComment API.
class LeaveReviewController extends GetxController {
  final SupportUseCase _supportUseCase = Get.find<SupportUseCase>();
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final RxBool isSubmitting = false.obs;

  /// Prefill name, email, phone from current user if logged in.
  Future<Map<String, String>> getPrefill() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return {};
    return {'name': user.name, 'email': user.email, 'phone': user.phone};
  }

  Future<bool> submit({
    required String name,
    required String message,
    required String email,
    required String phone,
    required String date,
  }) async {
    if (isSubmitting.value) return false;
    isSubmitting.value = true;
    try {
      final success = await _supportUseCase.saveComment(
        name: name,
        email: email,
        phone: phone,
        comment: message,
        date: date,
      );
      if (success) {
        Get.back();
        AppToast.showSuccess(AppTexts.success, AppTexts.reviewSubmitted);
        return true;
      }
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
      return false;
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
