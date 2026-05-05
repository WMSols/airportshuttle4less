import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_payment_info_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_select_vehicle_controller.dart';

class ReservationTabFlowController extends GetxController {
  final currentTabIndex = 0.obs;
  final isRideInfoSubmitted = false.obs;
  final isVehicleSelected = false.obs;

  int get currentStep => currentTabIndex.value + 1;
  bool get canShowSelectVehicle => isRideInfoSubmitted.value;
  bool get canShowPaymentInfo =>
      isRideInfoSubmitted.value && isVehicleSelected.value;

  String get selectVehicleBlockedMessage =>
      AppTexts.completeRideInfoToViewVehicles;
  String get paymentBlockedMessage {
    if (!isRideInfoSubmitted.value) {
      return AppTexts.completeRideInfoToContinue;
    }
    return AppTexts.selectVehicleToContinue;
  }

  void goToTab(int index) {
    if (index <= 0) {
      currentTabIndex.value = 0;
      return;
    }
    if (index == 1) {
      currentTabIndex.value = 1;
      return;
    }
    currentTabIndex.value = 2;
  }

  void onRideInfoSubmitted() {
    isRideInfoSubmitted.value = true;
    isVehicleSelected.value = false;
    currentTabIndex.value = 1;
  }

  void onVehicleSelected() {
    isVehicleSelected.value = true;
    currentTabIndex.value = 2;
  }

  void onSelectVehicleBack() {
    currentTabIndex.value = 0;
  }

  void onPaymentBack() {
    currentTabIndex.value = 1;
  }

  Future<void> handleRefresh(context) async {
    final tabFlow = Get.find<ReservationTabFlowController>();
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppTexts.resetReservationTitle),
        content: Row(
          children: [
            Image.asset(AppImages.noDataYet, height: 40),
            const SizedBox(width: 12),
            const Expanded(child: Text(AppTexts.resetReservationMessage)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppTexts.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppTexts.yes),
          ),
        ],
      ),
    );

    if (shouldReset == true) {
      tabFlow.resetReservationFlow();
    }
  }

  void resetReservationFlow() {
    Get.find<ReservationFlowController>().reset();

    if (Get.isRegistered<ReservationRideInfoController>()) {
      Get.find<ReservationRideInfoController>().clearInputs();
    }
    if (Get.isRegistered<ReservationSelectVehicleController>()) {
      Get.find<ReservationSelectVehicleController>().clearSelectionState();
    }
    if (Get.isRegistered<ReservationPaymentInfoController>()) {
      Get.find<ReservationPaymentInfoController>().clearInputs();
    }

    isRideInfoSubmitted.value = false;
    isVehicleSelected.value = false;
    currentTabIndex.value = 0;
  }
}
