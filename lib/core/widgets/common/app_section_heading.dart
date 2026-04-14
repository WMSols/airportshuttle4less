import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class AppSectionHeading extends StatelessWidget {
  const AppSectionHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final lineThickness = AppResponsive.scaleSize(context, 1);
    final sideGap = AppSpacing.horizontalValue(context, 0.01);
    final linesGap = AppSpacing.verticalValue(context, 0.004);

    return Row(
      children: [
        Expanded(
          child: _DoubleSideLine(
            thickness: lineThickness,
            gap: linesGap,
            trailingGap: sideGap,
          ),
        ),
        Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: AppResponsive.screenWidth(context) * 0.05,
          ),
        ),
        Expanded(
          child: _DoubleSideLine(
            thickness: lineThickness,
            gap: linesGap,
            trailingGap: sideGap,
            isRight: true,
          ),
        ),
      ],
    );
  }
}

class _DoubleSideLine extends StatelessWidget {
  const _DoubleSideLine({
    required this.thickness,
    required this.gap,
    required this.trailingGap,
    this.isRight = false,
  });

  final double thickness;
  final double gap;
  final double trailingGap;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    final line = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.55,
            child: Container(height: thickness, color: AppColors.black),
          ),
        ),
        SizedBox(height: gap),
        Container(height: thickness, color: AppColors.black),
      ],
    );

    return Row(
      children: isRight
          ? [SizedBox(width: trailingGap), Expanded(child: line)]
          : [Expanded(child: line), SizedBox(width: trailingGap)],
    );
  }
}
