import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/constants/reservation_constants.dart';
import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_date_time_tile.dart';
import 'package:airportshuttle4less/core/widgets/form/app_checkbox/app_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_places_autocomplete_field/app_places_autocomplete_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Airport service form: To/From, airport, address, passengers, date-time, flight, return.
/// Conditional fields based on:
/// - To Airport vs From Airport selection
/// - Return Reservations checkbox
class ReservationAirportForm extends StatelessWidget {
  const ReservationAirportForm({
    super.key,
    required this.flow,
    required this.controller,
    required this.pickupController,
    required this.dropController,
    required this.passengersController,
    required this.flightController,
    required this.returnFlightController,
  });

  final ReservationFlowController flow;
  final ReservationRideInfoController controller;
  final TextEditingController pickupController;
  final TextEditingController dropController;
  final TextEditingController passengersController;
  final TextEditingController flightController;
  final TextEditingController returnFlightController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final toFrom =
          flow.toFromAirport.value; // true = To Airport, false = From Airport
      final isReturn = flow.isReturn.value;
      final catalog = Get.find<ReservationPricingCatalogService>();
      final airportOptions = controller.airportOptions(catalog.airports);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Select Service (To Airport / From Airport)
          AppDropdownField<bool>(
            label: AppTexts.selectService,
            hint: AppTexts.select,
            value: toFrom,
            items: const [true, false],
            getLabel: (v) =>
                v == true ? AppTexts.toAirport : AppTexts.fromAirport,
            onChanged: controller.setServiceDirection,
          ),
          AppSpacing.vertical(context, 0.02),

          // Select Airport (always shown)
          AppDropdownField<String>(
            label: AppTexts.selectAirport,
            hint: AppTexts.select,
            value: airportOptions.selectedValue,
            items: airportOptions.items,
            getLabel: (id) => airportOptions.labels[id] ?? id,
            onChanged: (id) =>
                controller.setAirportSelection(id, airportOptions.labels),
          ),
          AppSpacing.vertical(context, 0.02),

          // Pickup Location (only for To Airport)
          if (toFrom) ...[
            AppPlacesAutocompleteField(
              controller: pickupController,
              label: AppTexts.pickupLocation,
              hint: AppTexts.enterAddress,
              onChanged: controller.setPickupAddress,
            ),
            AppSpacing.vertical(context, 0.02),
          ],

          // Drop Location (only for From Airport)
          if (!toFrom) ...[
            AppPlacesAutocompleteField(
              controller: dropController,
              label: AppTexts.dropLocation,
              hint: AppTexts.enterAddress,
              onChanged: controller.setDropAddress,
            ),
            AppSpacing.vertical(context, 0.02),
          ],

          // Passengers (always shown)
          AppTextField(
            controller: passengersController,
            label: AppTexts.passengers,
            hint: AppTexts.enterNumberOfPassengers,
            keyboardType: TextInputType.number,
            onChanged: controller.setPassengerCount,
          ),
          AppSpacing.vertical(context, 0.02),

          // Pickup Date + Pickup Time (To Airport)
          if (toFrom) ...[
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
          ],

          // Drop Date + Drop Time + Flight details (From Airport)
          if (!toFrom) ...[
            ReservationDateTimeTile(
              dateTime: flow.pickupDateTime,
              label: AppTexts.dropDateLabel,
              showTime: false,
              onSelected: controller.setPickupDate,
            ),
            AppSpacing.vertical(context, 0.02),
            ReservationDateTimeTile(
              dateTime: flow.pickupDateTime,
              label: AppTexts.dropTimeLabel,
              showDate: false,
              onSelected: controller.setPickupDateTime,
            ),
            AppSpacing.vertical(context, 0.02),

            // Flight Number (only for From Airport)
            AppTextField(
              controller: flightController,
              label: AppTexts.flightNumber,
              hint: AppTexts.flightNumberHint,
              onChanged: controller.setFlightNumber,
            ),
            AppSpacing.vertical(context, 0.01),

            // Airlines (only for From Airport)
            AppDropdownField<String>(
              label: AppTexts.airlinesLabel,
              hint: AppTexts.airlinesHint,
              value: flow.airlines.value.isEmpty ? null : flow.airlines.value,
              items: ReservationConstants.airlines,
              getLabel: (airline) => airline,
              onChanged: controller.setAirline,
            ),
            AppSpacing.vertical(context, 0.02),
          ],

          // Return Reservations Checkbox
          AppCheckbox(
            value: flow.isReturn.value,
            onChanged: controller.toggleReturnReservation,
            label: AppTexts.returnReservations,
          ),

          // Return Fields (only when Return is checked)
          if (isReturn) ...[
            AppSpacing.vertical(context, 0.02),

            // Return + To Airport
            if (toFrom) ...[
              ReservationDateTimeTile(
                dateTime: flow.returnDateTime,
                label: AppTexts.pickupDateLabel,
                showTime: false,
                onSelected: controller.setReturnDate,
              ),
              AppSpacing.vertical(context, 0.02),
              ReservationDateTimeTile(
                dateTime: flow.returnDateTime,
                label: AppTexts.flightArrivalTime,
                showDate: false,
                onSelected: controller.setReturnDateTime,
              ),
              AppSpacing.vertical(context, 0.02),

              // Return Flight Number
              AppTextField(
                controller: returnFlightController,
                label: AppTexts.flightNumber,
                hint: AppTexts.flightNumberHint,
                onChanged: controller.setReturnFlightNumber,
              ),
              AppSpacing.vertical(context, 0.01),

              // Return Airlines
              AppDropdownField<String>(
                label: AppTexts.airlinesLabel,
                hint: AppTexts.airlinesHint,
                value: flow.returnAirlines.value.isEmpty
                    ? null
                    : flow.returnAirlines.value,
                items: ReservationConstants.airlines,
                getLabel: (airline) => airline,
                onChanged: controller.setReturnAirline,
              ),
            ],

            // Return + From Airport: Return Drop Date + Return Drop-off Time
            if (!toFrom) ...[
              ReservationDateTimeTile(
                dateTime: flow.returnDateTime,
                label: AppTexts.returnDropDate,
                showTime: false,
                onSelected: controller.setReturnDate,
              ),
              AppSpacing.vertical(context, 0.02),
              ReservationDateTimeTile(
                dateTime: flow.returnDateTime,
                label: AppTexts.returnDropTime,
                showDate: false,
                onSelected: controller.setReturnDateTime,
              ),
              AppSpacing.vertical(context, 0.02),
              AppTextField(
                controller: returnFlightController,
                label: AppTexts.flightNumber,
                hint: AppTexts.flightNumberHint,
                onChanged: controller.setReturnFlightNumber,
              ),
              AppSpacing.vertical(context, 0.01),
              AppDropdownField<String>(
                label: AppTexts.airlinesLabel,
                hint: AppTexts.airlinesHint,
                value: flow.returnAirlines.value.isEmpty
                    ? null
                    : flow.returnAirlines.value,
                items: ReservationConstants.airlines,
                getLabel: (airline) => airline,
                onChanged: controller.setReturnAirline,
              ),
            ],
          ],
        ],
      );
    });
  }
}
