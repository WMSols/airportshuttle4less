import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

/// Three-step progress: 1 Ride Info, 2 Select Vehicle, 3 Payment Info.
class ReservationStepIndicator extends StatelessWidget {
  const ReservationStepIndicator({super.key, required this.currentStep});

  /// 1-based: 1 = Ride Info, 2 = Select Vehicle, 3 = Payment Info
  final int currentStep;

  static String _stepLabel(int step) {
    switch (step) {
      case 1:
        return AppTexts.rideInfo;
      case 2:
        return AppTexts.selectVehicle;
      case 3:
        return AppTexts.paymentInfo;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0, v: 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          final step = i + 1;
          final isActive = step == currentStep;
          final isPast = step < currentStep;
          return Expanded(
            child: _StepCircle(
              number: step,
              isActive: isActive,
              isCompleted: isPast,
            ),
          );
        }),
      ),
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({
    required this.number,
    required this.isActive,
    required this.isCompleted,
  });

  final int number;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppResponsive.iconSize(context, factor: 1.5),
          height: AppResponsive.iconSize(context, factor: 1.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? AppColors.primary
                : isCompleted
                ? AppColors.primary
                : AppColors.grey.withValues(alpha: 0.3),
          ),
          alignment: Alignment.center,
          child: isCompleted
              ? Icon(
                  Icons.check,
                  size: AppResponsive.iconSize(context),
                  color: AppColors.white,
                )
              : Text(
                  '$number',
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: isActive || isCompleted
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
        ),
        AppSpacing.vertical(context, 0.005),
        Text(
          ReservationStepIndicator._stepLabel(number),
          style: AppTextStyles.hintText(
            context,
          ).copyWith(color: isActive ? AppColors.primary : AppColors.black),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
