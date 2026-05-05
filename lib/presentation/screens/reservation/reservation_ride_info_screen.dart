import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_airport_form.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_hourly_form.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_ptp_form.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_service_tabs.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_step_indicator.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Step 1: Ride Info — service type tabs and trip details.
class ReservationRideInfoScreen extends StatelessWidget {
  const ReservationRideInfoScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRideInfoController>();
    final flow = Get.find<ReservationFlowController>();

    final content = Column(
      children: [
        if (!embedded) const ReservationStepIndicator(currentStep: 1),
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
            child: Form(
              key: controller.formKey,
              child: Obx(() {
                final type = flow.serviceType.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ReservationServiceTabs(flow: flow, controller: controller),
                    AppSpacing.vertical(context, 0.02),
                    if (type == ReservationServiceType.airport)
                      ReservationAirportForm(
                        flow: flow,
                        controller: controller,
                        pickupController: controller.pickupController,
                        dropController: controller.dropController,
                        passengersController: controller.passengersController,
                        flightController: controller.flightController,
                        returnFlightController:
                            controller.returnFlightController,
                      )
                    else if (type == ReservationServiceType.pointToPoint)
                      ReservationPtpForm(
                        flow: flow,
                        controller: controller,
                        pickupController: controller.pickupController,
                        dropController: controller.dropController,
                        passengersController: controller.passengersController,
                        returnPickupController:
                            controller.returnPickupController,
                        returnDropController: controller.returnDropController,
                      )
                    else if (type == ReservationServiceType.hourly)
                      ReservationHourlyForm(
                        flow: flow,
                        controller: controller,
                        pickupController: controller.pickupController,
                        dropController: controller.dropController,
                        passengersController: controller.passengersController,
                      ),
                    AppSpacing.vertical(context, 0.04),
                    AppButton(
                      label: AppTexts.searchNow,
                      onPressed: controller.submitSearch,
                      backgroundColor: AppColors.primary,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );

    if (embedded) {
      return ColoredBox(
        color: AppColors.white,
        child: SafeArea(child: content),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(title: AppTexts.rideInfo),
      body: SafeArea(child: content),
    );
  }
}
