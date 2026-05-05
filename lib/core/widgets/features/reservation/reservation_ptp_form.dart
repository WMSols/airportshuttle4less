import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_date_time_tile.dart';
import 'package:airportshuttle4less/core/widgets/form/app_checkbox/app_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_places_autocomplete_field/app_places_autocomplete_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Point-to-point service form: pickup, drop, passengers, date-time.
class ReservationPtpForm extends StatelessWidget {
  const ReservationPtpForm({
    super.key,
    required this.flow,
    required this.controller,
    required this.pickupController,
    required this.dropController,
    required this.passengersController,
    required this.returnPickupController,
    required this.returnDropController,
  });

  final ReservationFlowController flow;
  final ReservationRideInfoController controller;
  final TextEditingController pickupController;
  final TextEditingController dropController;
  final TextEditingController passengersController;
  final TextEditingController returnPickupController;
  final TextEditingController returnDropController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppPlacesAutocompleteField(
            controller: pickupController,
            label: AppTexts.pickupLocation,
            hint: AppTexts.enterAddress,
            onChanged: controller.setPtpPickup,
          ),
          AppSpacing.vertical(context, 0.02),
          AppPlacesAutocompleteField(
            controller: dropController,
            label: AppTexts.dropLocation,
            hint: AppTexts.enterAddress,
            onChanged: controller.setPtpDrop,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            controller: passengersController,
            label: AppTexts.passengers,
            hint: AppTexts.enterNumberOfPassengers,
            keyboardType: TextInputType.number,
            onChanged: controller.setPassengerCount,
          ),
          AppSpacing.vertical(context, 0.02),
          ReservationDateTimeTile(
            dateTime: flow.pickupDateTime,
            label: AppTexts.pickupDateLabel,
            showTime: false,
            onSelected: controller.setPickupDate,
          ),
          AppSpacing.vertical(context, 0.02),
          ReservationDateTimeTile(
            dateTime: flow.pickupDateTime,
            label: AppTexts.pickupTimeLabel,
            showDate: false,
            onSelected: controller.setPickupDateTime,
          ),
          AppSpacing.vertical(context, 0.02),
          AppCheckbox(
            value: flow.isReturn.value,
            onChanged: controller.toggleReturnReservation,
            label: AppTexts.returnReservations,
          ),
          if (flow.isReturn.value) ...[
            AppSpacing.vertical(context, 0.02),
            AppPlacesAutocompleteField(
              controller: returnPickupController,
              label: AppTexts.pickupLocation,
              hint: AppTexts.enterAddress,
              onChanged: controller.setReturnPickupAddress,
            ),
            AppSpacing.vertical(context, 0.02),
            AppPlacesAutocompleteField(
              controller: returnDropController,
              label: AppTexts.dropLocation,
              hint: AppTexts.enterAddress,
              onChanged: controller.setReturnDropAddress,
            ),
            AppSpacing.vertical(context, 0.02),
            ReservationDateTimeTile(
              dateTime: flow.returnDateTime,
              label: AppTexts.returnPickupDate,
              showTime: false,
              onSelected: controller.setReturnDate,
            ),
            AppSpacing.vertical(context, 0.02),
            ReservationDateTimeTile(
              dateTime: flow.returnDateTime,
              label: AppTexts.pickupTimeLabel,
              showDate: false,
              onSelected: controller.setReturnDateTime,
            ),
          ],
        ],
      ),
    );
  }
}
