import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_date_time_tile.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_places_autocomplete_field/app_places_autocomplete_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Hourly service form: pickup, passengers, date-time, hours.
class ReservationHourlyForm extends StatelessWidget {
  const ReservationHourlyForm({
    super.key,
    required this.flow,
    required this.controller,
    required this.pickupController,
    required this.dropController,
    required this.passengersController,
  });

  final ReservationFlowController flow;
  final ReservationRideInfoController controller;
  final TextEditingController pickupController;
  final TextEditingController dropController;
  final TextEditingController passengersController;

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
            onChanged: controller.setHourlyPickup,
          ),
          AppSpacing.vertical(context, 0.02),
          AppPlacesAutocompleteField(
            controller: dropController,
            label: AppTexts.dropLocation,
            hint: AppTexts.enterAddress,
            onChanged: controller.setHourlyDrop,
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
          AppDropdownField<int>(
            label: AppTexts.hoursLabel,
            hint: AppTexts.select,
            value: flow.hourlyHours.value,
            items: List.generate(22, (i) => i + 3),
            getLabel: (h) => '$h',
            onChanged: controller.setHourlyHours,
          ),
          AppSpacing.vertical(context, 0.02),
          ReservationDateTimeTile(
            dateTime: flow.pickupDateTime,
            label: AppTexts.pickupTimeLabel,
            showDate: false,
            onSelected: controller.setPickupDateTime,
          ),
        ],
      ),
    );
  }
}
