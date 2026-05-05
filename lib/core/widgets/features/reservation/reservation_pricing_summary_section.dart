import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_helper/app_helper.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_payment_info_controller.dart';
import 'package:iconsax/iconsax.dart';

/// Pricing summary and offer code for Payment Info step.
class ReservationPricingSummarySection extends StatelessWidget {
  const ReservationPricingSummarySection({
    super.key,
    required this.flow,
    required this.controller,
    required this.offerController,
    required this.onApplyOffer,
  });

  final ReservationFlowController flow;
  final ReservationPaymentInfoController controller;
  final TextEditingController offerController;
  final VoidCallback onApplyOffer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.45)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: AppResponsive.screenHeight(context) * 0.17,
              child: Image.asset(
                flow.selectedVehicleName.value.vehicleImageAsset,
                fit: BoxFit.contain,
              ),
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: AppTexts.baseFare,
              value:
                  '\$ ${flow.selectedVehicleBaseCharge.value.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.map,
              label: AppTexts.approxDistance,
              value:
                  '${flow.distanceMiles.value.toStringAsFixed(2)} ${AppTexts.miles}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: 'Cost Per Miles',
              value: '\$ ${flow.costPerMile.value.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: AppTexts.subTotal,
              value: '\$ ${flow.effectiveSubTotal.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: 'Late Night Charges',
              value: '\$ ${flow.lateNightCharge.value.toStringAsFixed(2)}',
            ),
            const Divider(),
            AppDetailRow(
              icon: Iconsax.money,
              label: 'Extra Bags',
              value: '\$ ${flow.extraBagCharge.value.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: 'Parking',
              value: '\$ ${flow.parkingCharge.value.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: 'Toll',
              value: '\$ ${flow.tollCharge.value.toStringAsFixed(2)}',
            ),
            AppSpacing.vertical(context, 0.004),
            Row(
              children: [
                Expanded(
                  child: AppDropdownField<int>(
                    label: 'Extra Bags',
                    hint: AppTexts.select,
                    value: flow.extraBags.value,
                    items: const [0, 1, 2, 3, 4, 5],
                    getLabel: (v) => '$v',
                    onChanged: controller.setExtraBags,
                  ),
                ),
                AppSpacing.horizontal(context, 0.02),
                Text('\$ ${flow.extraBagCharge.value.toStringAsFixed(2)}'),
              ],
            ),
            AppSpacing.vertical(context, 0.01),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: offerController,
                    hint: AppTexts.offerCode,
                  ),
                ),
                AppSpacing.horizontal(context, 0.02),
                AppButton(
                  label: AppTexts.applyPromo,
                  onPressed: onApplyOffer,
                  backgroundColor: AppColors.primary,
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.008),
            AppDetailRow(
              icon: Iconsax.money,
              label: flow.offerCode.value.isEmpty
                  ? 'Offer is not Applied'
                  : AppTexts.offerApplied,
              value: '- \$ ${flow.offerDiscount.value.toStringAsFixed(2)}',
            ),
            Row(
              children: [
                Expanded(
                  child: AppDropdownField<int>(
                    label: '${AppTexts.gratuityLabel} (Recommended 15%)',
                    hint: AppTexts.select,
                    value: flow.gratuityPercent.value,
                    items: ReservationPaymentInfoController.gratuityOptions,
                    getLabel: (v) => '$v%',
                    onChanged: controller.setGratuityPercent,
                  ),
                ),
                AppSpacing.horizontal(context, 0.02),
                Text('\$ ${flow.gratuityAmount.toStringAsFixed(2)}'),
              ],
            ),
            AppSpacing.vertical(context, 0.01),
            AppDetailRow(
              icon: Iconsax.money,
              label: AppTexts.cardProcessingFee,
              value:
                  '\$ ${flow.cardProcessingFeeAmount.value.toStringAsFixed(2)}',
            ),
            AppDetailRow(
              icon: Iconsax.money,
              label: AppTexts.grandTotal,
              value: '\$ ${flow.totalFare.value.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}
