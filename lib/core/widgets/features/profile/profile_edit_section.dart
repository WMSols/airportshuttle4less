import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';
import 'package:airportshuttle4less/domain/entities/user.dart';

/// Profile section showing user details (name, email, phone) with edit icon. Tapping navigates to Edit Profile.
class ProfileEditSection extends StatelessWidget {
  const ProfileEditSection({
    super.key,
    required this.user,
    required this.onTap,
  });

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Padding(
        padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppTexts.editProfile,
                    style: AppTextStyles.bodyText(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Icon(
                  Iconsax.edit_2,
                  size: AppResponsive.iconSize(context),
                  color: AppColors.primary,
                ),
              ],
            ),
            AppSpacing.vertical(context, 0.015),
            AppDetailRow(
              icon: Iconsax.user,
              label: AppTexts.fullName,
              value: user.name,
            ),
            AppSpacing.vertical(context, 0.012),
            AppDetailRow(
              icon: Iconsax.sms,
              label: AppTexts.email,
              value: user.email,
            ),
            AppSpacing.vertical(context, 0.012),
            AppDetailRow(
              icon: Iconsax.call,
              label: AppTexts.phoneNumber,
              value: user.phone,
            ),
          ],
        ),
      ),
    );
  }
}
