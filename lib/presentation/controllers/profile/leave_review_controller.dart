import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';

/// Controller for Leave Review form: submit via SaveComment API.
class LeaveReviewController extends GetxController {
  final SupportUseCase _supportUseCase = Get.find<SupportUseCase>();
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  final RxBool isSubmitting = false.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final messageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final selectedDate = Rxn<DateTime>();

  String get dateDisplay => selectedDate.value != null
      ? DateFormat('dd/MM/yyyy').format(selectedDate.value!)
      : '';
  String get dateApi => selectedDate.value != null
      ? DateFormat('yyyy-MM-dd').format(selectedDate.value!)
      : '';

  @override
  void onReady() {
    super.onReady();
    getPrefill();
  }

  /// Prefill name, email, phone from current user if logged in.
  Future<void> getPrefill() async {
    final user = await _authUseCase.getCurrentUser();
    if (user == null) return;
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
  }

  Future<void> openDatePicker(
    BuildContext context, {
    required String title,
  }) async {
    final now = DateTime.now();
    final picked = await AppDateTimePicker.show(
      context,
      title: title,
      initial: selectedDate.value ?? now,
      minDate: now,
      maxDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<bool> submit() async {
    if (isSubmitting.value) return false;
    isSubmitting.value = true;
    try {
      final success = await _supportUseCase.saveComment(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        comment: messageController.text.trim(),
        date: dateApi,
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

  @override
  void onClose() {
    nameController.dispose();
    messageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
