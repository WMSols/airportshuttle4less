import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/domain/entities/user.dart';

/// Profile header: avatar and full name.
class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final avatarSize = AppResponsive.scaleSize(context, 100);
    return Column(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Iconsax.user,
            size: AppResponsive.scaleSize(context, 50),
            color: AppColors.white,
          ),
        ),
        if (user.name.isNotEmpty) ...[
          AppSpacing.vertical(context, 0.015),
          Text(
            user.name.toUpperCase(),
            style: AppTextStyles.heading(context).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.primaryFont,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
