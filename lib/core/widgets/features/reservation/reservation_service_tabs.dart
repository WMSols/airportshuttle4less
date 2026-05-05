import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_ride_info_controller.dart';

/// Service type tabs: Airport, Point to Point, Hourly.
class ReservationServiceTabs extends StatelessWidget {
  const ReservationServiceTabs({
    super.key,
    required this.flow,
    required this.controller,
  });

  final ReservationFlowController flow;
  final ReservationRideInfoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final type = flow.serviceType.value;
      final gap = AppSpacing.horizontalValue(context, 0.02);
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(
              width: AppResponsive.screenWidth(context) * 0.28,
              child: _ReservationTabChip(
                label: AppTexts.tabAirport,
                selected: type == ReservationServiceType.airport,
                onTap: () =>
                    controller.setServiceType(ReservationServiceType.airport),
              ),
            ),
            SizedBox(width: gap),
            SizedBox(
              width: AppResponsive.screenWidth(context) * 0.34,
              child: _ReservationTabChip(
                label: AppTexts.tabPointToPoint,
                selected: type == ReservationServiceType.pointToPoint,
                onTap: () => controller.setServiceType(
                  ReservationServiceType.pointToPoint,
                ),
              ),
            ),
            SizedBox(width: gap),
            SizedBox(
              width: AppResponsive.screenWidth(context) * 0.24,
              child: _ReservationTabChip(
                label: AppTexts.tabHourly,
                selected: type == ReservationServiceType.hourly,
                onTap: () =>
                    controller.setServiceType(ReservationServiceType.hourly),
              ),
            ),
            SizedBox(width: gap),
          ],
        ),
      );
    });
  }
}

class _ReservationTabChip extends StatelessWidget {
  const _ReservationTabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: AppSpacing.symmetric(context, h: 0.01, v: 0.012),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.black,
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.grey,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.hintText(context).copyWith(
            color: AppColors.white,
            fontSize: AppResponsive.screenWidth(context) * 0.028,
            height: 1.15,
          ),
        ),
      ),
    );
  }
}
