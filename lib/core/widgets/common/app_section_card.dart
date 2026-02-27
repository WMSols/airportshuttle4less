import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_info_card.dart';

/// Card with icon + title header and [child]. Uses [AppInfoCard] internally.
class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final color = titleColor ?? AppColors.primary;
    return AppInfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppResponsive.iconSize(context, factor: 1.1),
                color: color,
              ),
              AppSpacing.horizontal(context, 0.02),
              Text(
                title,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.primaryFont,
                  color: color,
                ),
              ),
            ],
          ),
          AppSpacing.vertical(context, 0.015),
          child,
        ],
      ),
    );
  }
}
