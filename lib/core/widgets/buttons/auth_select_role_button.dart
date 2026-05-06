import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class AuthSelectRoleButton extends StatelessWidget {
  const AuthSelectRoleButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  final String imagePath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Container(
        padding: AppSpacing.all(context),
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
            AppSpacing.vertical(context, 0.01),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText(context).copyWith(
                color: AppColors.white,
                fontFamily: AppFonts.primaryFont,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
