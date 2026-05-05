import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';

class ContactUsController extends GetxController {
  final SupportUseCase _supportUseCase = Get.find<SupportUseCase>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final smsConsent = false.obs;
  final isSubmitting = false.obs;

  String? validateName(String? v) => AppValidators.validateRequiredName(v);
  String? validatePhone(String? v) => AppValidators.validatePhone(v);
  String? validateEmail(String? v) => AppValidators.validateEmail(v);
  String? validateMessage(String? v) =>
      AppValidators.validateRequired(v, AppTexts.message);

  void setSmsConsent(bool value) => smsConsent.value = value;

  Future<void> submit() async {
    if (formKey.currentState?.validate() != true) return;
    if (!smsConsent.value) {
      AppToast.showError(AppTexts.error, AppTexts.smsConsentRequired);
      return;
    }
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    try {
      final success = await _supportUseCase.sendEnquiry(
        name: nameController.text.trim(),
        mobileNo: mobileController.text.trim(),
        email: emailController.text.trim(),
        message: messageController.text.trim(),
      );
      if (success) {
        Get.back();
        AppToast.showSuccess(AppTexts.success, AppTexts.messageSentSuccess);
      } else {
        AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
      }
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
