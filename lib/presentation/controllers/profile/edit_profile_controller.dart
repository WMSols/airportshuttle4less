import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/profile_controller.dart';

/// Controller for edit profile screen. Loads current user, allows editing name and phone.
class EditProfileController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isSaving = false.obs;

  /// Called by [EditProfileScreen] so the controller uses widget-owned controllers.
  void setTextControllers({
    required TextEditingController name,
    required TextEditingController phone,
  }) {
    nameController = name;
    phoneController = phone;
  }

  @override
  void onReady() {
    super.onReady();
    _loadUser();
  }

  Future<void> _loadUser() async {
    isLoading.value = true;
    try {
      final user = await _authUseCase.getCurrentUser();
      if (user != null) {
        nameController.text = user.name;
        phoneController.text = user.phone;
      }
    } finally {
      isLoading.value = false;
    }
  }

  String? validateName(String? value) =>
      AppValidators.validateRequiredName(value);
  String? validatePhone(String? value) => AppValidators.validatePhone(value);

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;
    try {
      await _authUseCase.updateProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      );
      if (Get.isRegistered<ProfileController>()) {
        await Get.find<ProfileController>().loadUser();
      }
      AppToast.showSuccess(AppTexts.success, AppTexts.save);
      Get.back();
    } catch (e) {
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
    } finally {
      isSaving.value = false;
    }
  }
}
