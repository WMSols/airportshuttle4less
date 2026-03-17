import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

/// A single profile menu row: leading icon, title, optional subtitle, trailing arrow.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Container(
        padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
                color: AppColors.primary,
              ),
              child: Padding(
                padding: AppSpacing.all(context) * 0.8,
                child: Icon(
                  icon,
                  size: AppResponsive.iconSize(context),
                  color: AppColors.white,
                ),
              ),
            ),
            AppSpacing.horizontal(context, 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    Text(
                      subtitle!,
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: AppColors.white),
                    ),
                  ],
                ],
              ),
            ),
            AppIconButton(
              icon: Iconsax.arrow_right_3,
              color: AppColors.white,
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
