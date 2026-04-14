import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

/// Section header for a group of FAQs (e.g. "Welcome to AS4L", "General FAQ's").
class FaqSectionHeader extends StatelessWidget {
  const FaqSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0, v: 0.01),
      child: Text(
        title,
        style: AppTextStyles.bodyText(context).copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
    );
  }
}
