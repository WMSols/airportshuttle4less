import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';

/// Reusable dots indicator for page views. Uses [AnimatedContainer] for
/// smooth transitions when the selected index changes.
class AppDotsIndicator extends StatelessWidget {
  const AppDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.activeDotSize,
    this.inactiveDotSize,
  });

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? activeDotSize;
  final double? inactiveDotSize;

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? AppColors.primary;
    final inactive = inactiveColor ?? AppColors.black;
    final activeDotSize =
        this.activeDotSize ?? AppResponsive.scaleSize(context, 150);
    final inactiveDotSize =
        this.inactiveDotSize ?? AppResponsive.scaleSize(context, 30);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppSpacing.horizontalValue(context, 0.01),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: currentIndex == i ? activeDotSize : inactiveDotSize,
            height: AppResponsive.scaleSize(context, 8),
            decoration: BoxDecoration(
              color: currentIndex == i ? active : Colors.transparent,
              border: Border.all(
                color: currentIndex == i ? Colors.transparent : inactive,
              ),
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
