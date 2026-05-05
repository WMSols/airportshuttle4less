import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_booking_details_section.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_note_banner.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_personal_details_section.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_pricing_summary_section.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_review_terms_section.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_step_indicator.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_payment_info_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_tab_flow_controller.dart';

/// Step 3: Payment Info — review, personal details, terms, Complete Booking.
class ReservationPaymentInfoScreen extends StatelessWidget {
  const ReservationPaymentInfoScreen({
    super.key,
    this.embedded = false,
    this.onBack,
  });

  final bool embedded;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationPaymentInfoController>();
    final flow = Get.find<ReservationFlowController>();

    final content = Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
      child: Column(
        children: [
          if (!embedded) const ReservationStepIndicator(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                flow.recomputeTotals();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ReservationNoteBanner(),
                    AppSpacing.vertical(context, 0.02),
                    ReservationBookingDetailsSection(flow: flow),
                    AppSpacing.vertical(context, 0.02),
                    ReservationPersonalDetailsSection(
                      fullName:
                          controller.user.value?.name.trim().isNotEmpty == true
                          ? controller.user.value!.name.trim()
                          : '${flow.firstName.value} ${flow.lastName.value}'
                                .trim(),
                      phone: controller.user.value?.phone ?? flow.phone.value,
                      email: controller.user.value?.email ?? flow.email.value,
                    ),
                    AppSpacing.vertical(context, 0.02),
                    ReservationPricingSummarySection(
                      flow: flow,
                      controller: controller,
                      offerController: controller.offerController,
                      onApplyOffer: controller.applyOffer,
                    ),
                    AppSpacing.vertical(context, 0.02),
                    ReservationReviewTermsSection(
                      flow: flow,
                      controller: controller,
                    ),
                    AppSpacing.vertical(context, 0.02),
                    if (controller.submitError.value != null)
                      Padding(
                        padding: AppSpacing.symmetric(context, v: 0.01),
                        child: Text(
                          controller.submitError.value!,
                          style: AppTextStyles.hintText(
                            context,
                          ).copyWith(color: AppColors.error),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
          Column(
            children: [
              Obx(
                () => AppButton(
                  label: AppTexts.completeBooking,
                  onPressed: controller.submitting.value
                      ? null
                      : controller.completeBooking,
                  backgroundColor: flow.acceptTerms.value
                      ? AppColors.primary
                      : AppColors.grey,
                  isLoading: controller.submitting.value,
                ),
              ),
              AppSpacing.vertical(context, 0.01),
              AppButton(
                label: AppTexts.back,
                onPressed:
                    onBack ??
                    () {
                      if (Get.isRegistered<ReservationTabFlowController>()) {
                        Get.find<ReservationTabFlowController>()
                            .onPaymentBack();
                        return;
                      }
                      Get.back();
                    },
                backgroundColor: AppColors.black,
              ),
            ],
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
      appBar: AppCustomAppBar(title: AppTexts.paymentInfo, isBack: true),
      body: SafeArea(child: content),
    );
  }
}
