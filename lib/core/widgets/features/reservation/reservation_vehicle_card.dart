import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_helper/app_helper.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_feature_strip.dart';
import 'package:airportshuttle4less/data/models/vehicle/reservation_vehicle_model.dart';

/// Vehicle card for Select Vehicle step: full-width layout with image area,
/// model/title and feature strip similar to preferred vehicle cards.
class ReservationVehicleCard extends StatelessWidget {
  const ReservationVehicleCard({
    super.key,
    required this.vehicle,
    required this.onBookNow,
  });

  final ReservationVehicleModel vehicle;
  final VoidCallback onBookNow;

  @override
  Widget build(BuildContext context) {
    final radius = AppResponsive.radius(context);
    final features = <({IconData icon, String? value})>[
      (icon: Iconsax.user, value: '${vehicle.maxCapacity}'),
      (icon: Iconsax.briefcase, value: '${vehicle.maxBaggage}'),
      (icon: Iconsax.wifi, value: null),
      (icon: Iconsax.card, value: null),
      (icon: Iconsax.flash_1, value: null),
      (icon: Iconsax.note_1, value: null),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.black),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: AppResponsive.screenHeight(context) * 0.18,
            child: Padding(
              padding: AppSpacing.symmetric(context, h: 0.03, v: 0.01),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(radius * 0.8),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  vehicle.model.vehicleImageAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Iconsax.car,
                    size: AppResponsive.iconSize(context) * 2.6,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.symmetric(context, h: 0.02, v: 0.008),
            child: Column(
              children: [
                Text(
                  vehicle.model,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontFamily: AppFonts.primaryFont,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.vertical(context, 0.004),
                Text(
                  '${AppTexts.priceLabel}: \$${vehicle.baseCharge.toStringAsFixed(2)}',
                  style: AppTextStyles.hintText(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacing.vertical(context, 0.005),
                AppButton(
                  label: AppTexts.bookNow,
                  onPressed: onBookNow,
                  backgroundColor: AppColors.primary,
                ),
              ],
            ),
          ),
          AppSpacing.vertical(context, 0.005),
          AppFeatureStrip(
            useGrid: true,
            items: features.map((f) {
              final hasValue = f.value != null && f.value!.trim().isNotEmpty;
              final text = hasValue
                  ? '${f.icon.featureLabel}: ${f.value}'
                  : f.icon.featureLabel;
              return AppFeatureStripItem(icon: f.icon, text: text);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
