import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_step_indicator.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_tab_flow_controller.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_vehicle_card.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_select_vehicle_controller.dart';

/// Step 2: Select Vehicle — grid of vehicles from LoadVehicles API.
class ReservationSelectVehicleScreen extends StatelessWidget {
  const ReservationSelectVehicleScreen({
    super.key,
    this.embedded = false,
    this.onBack,
  });

  final bool embedded;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationSelectVehicleController>();

    final content = Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        children: [
          if (!embedded) const ReservationStepIndicator(currentStep: 2),
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.error.value != null) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.error.value!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyText(context),
                      ),
                      AppSpacing.vertical(context, 0.02),
                      AppButton(
                        label: AppTexts.retry,
                        onPressed: controller.loadVehicles,
                      ),
                    ],
                  ),
                );
              }
              if (controller.vehicles.isEmpty) {
                return Center(
                  child: Text(
                    AppTexts.noVehiclesAvailable,
                    style: AppTextStyles.bodyText(context),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (_, __) =>
                    AppSpacing.vertical(context, 0.015),
                itemCount: controller.vehicles.length,
                itemBuilder: (context, i) {
                  final v = controller.vehicles[i];
                  return ReservationVehicleCard(
                    vehicle: v,
                    onBookNow: () => controller.bookNow(v),
                  );
                },
              );
            }),
          ),
          AppButton(
            label: AppTexts.back,
            onPressed:
                onBack ??
                () {
                  if (Get.isRegistered<ReservationTabFlowController>()) {
                    Get.find<ReservationTabFlowController>()
                        .onSelectVehicleBack();
                    return;
                  }
                  Get.back();
                },
            backgroundColor: AppColors.black,
          ),
        ],
      ),
    );

    if (embedded) {
      return ColoredBox(
        color: AppColors.white,
        child: SafeArea(child: content),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(title: AppTexts.selectVehicle, isBack: true),
      body: SafeArea(child: content),
    );
  }
}
