import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a random booking reference
    final bookingRef =
        'ASL-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    final successIconContainerSize = AppResponsive.scaleSize(context, 100);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.all(context, factor: 1.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: successIconContainerSize,
                height: successIconContainerSize,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: AppResponsive.scaleSize(context, 60),
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Success Title
              Text(
                AppTexts.bookingConfirmed,
                style: AppTextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.vertical(context, 0.015),

              // Booking Reference
              Container(
                padding: AppSpacing.all(context),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: borderRadius,
                ),
                child: Column(
                  children: [
                    Text(
                      AppTexts.bookingReference,
                      style: AppTextStyles.hintText(context).copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    AppSpacing.vertical(context, 0.01),
                    Text(
                      bookingRef,
                      style: AppTextStyles.heading(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Details
              Text(
                'Your booking has been confirmed. You will receive a confirmation email shortly.',
                style: AppTextStyles.hintText(context).copyWith(
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),

              // View Booking Button
              SizedBox(
                width: double.infinity,
                height: AppResponsive.scaleSize(context, 50),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.main);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  ),
                  child: Text(
                    AppTexts.viewBooking,
                    style: AppTextStyles.buttonText(context),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Book Another Ride Button
              SizedBox(
                width: double.infinity,
                height: AppResponsive.scaleSize(context, 50),
                child: OutlinedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.main);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  ),
                  child: Text(
                    AppTexts.bookAnotherRide,
                    style: AppTextStyles.buttonText(context).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
