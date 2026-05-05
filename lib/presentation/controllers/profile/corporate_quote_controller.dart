import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';

class CorporateQuoteController extends GetxController {
  final SupportUseCase _supportUseCase = Get.find<SupportUseCase>();

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final pickUpLocationController = TextEditingController();
  final destinationController = TextEditingController();
  final hoursController = TextEditingController();
  final passengersController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final pickUpDateTime = Rxn<DateTime>();
  final serviceType = Rxn<String>();
  final vehicleType = Rxn<String>();
  final smsConsent = false.obs;
  final isSubmitting = false.obs;

  String get dateDisplay => pickUpDateTime.value != null
      ? DateFormat('dd/MM/yyyy').format(pickUpDateTime.value!)
      : '';
  String get timeDisplay => pickUpDateTime.value != null
      ? DateFormat('HH:mm').format(pickUpDateTime.value!)
      : '';
  String get dateApi => pickUpDateTime.value != null
      ? DateFormat('yyyy-MM-dd').format(pickUpDateTime.value!)
      : '';
  String get timeApi => pickUpDateTime.value != null
      ? DateFormat('HH:mm').format(pickUpDateTime.value!)
      : '';

  Future<void> openDateTimePicker(
    BuildContext context, {
    required String title,
  }) async {
    final now = DateTime.now();
    final picked = await AppDateTimePicker.show(
      context,
      title: title,
      initial: pickUpDateTime.value ?? now,
      minDate: now,
      maxDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      pickUpDateTime.value = picked;
    }
  }

  void setServiceType(String? value) => serviceType.value = value;
  void setVehicleType(String? value) => vehicleType.value = value;
  void setSmsConsent(bool value) => smsConsent.value = value;

  Future<void> submit() async {
    if (formKey.currentState?.validate() != true) return;
    if (pickUpDateTime.value == null ||
        serviceType.value == null ||
        serviceType.value!.isEmpty ||
        vehicleType.value == null ||
        vehicleType.value!.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    if (!smsConsent.value) {
      AppToast.showError(AppTexts.error, AppTexts.smsConsentRequired);
      return;
    }
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    try {
      final success = await _supportUseCase.sendQuoteMail(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        pickUpDate: dateApi,
        pickUpTime: timeApi,
        pickUpLocation: pickUpLocationController.text.trim(),
        destination: destinationController.text.trim(),
        serviceType: serviceType.value!,
        vehicleType: vehicleType.value!,
        hours: hoursController.text.trim(),
        passengers: passengersController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        message: messageController.text.trim(),
        currentPageUrl: ApiConstants.baseUrl,
      );
      if (success) {
        Get.back();
        AppToast.showSuccess(AppTexts.success, AppTexts.quoteRequestSuccess);
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
    firstNameController.dispose();
    lastNameController.dispose();
    pickUpLocationController.dispose();
    destinationController.dispose();
    hoursController.dispose();
    passengersController.dispose();
    phoneController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
