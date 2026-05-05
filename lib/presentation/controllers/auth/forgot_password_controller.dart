import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';

class ForgotPasswordController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['email'] != null) {
      emailController.text = args['email'].toString();
    }
  }

  String? validateEmail(String? value) => AppValidators.validateEmail(value);

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await _authUseCase.forgotPassword(emailController.text.trim());
      AppToast.showSuccess(AppTexts.success, AppTexts.resetLinkSent);
      Get.back();
    } catch (_) {
      AppToast.showError(AppTexts.error, AppTexts.couldNotSendResetLink);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
