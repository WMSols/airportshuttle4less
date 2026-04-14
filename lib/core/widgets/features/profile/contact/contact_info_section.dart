import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

/// Reusable contact info block: phone, email, location in a card layout.
class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key, this.phone, this.email, this.location});

  final String? phone;
  final String? email;
  final String? location;

  @override
  Widget build(BuildContext context) {
    final radius = AppResponsive.radius(context);
    return Container(
      padding: AppSpacing.all(context),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDetailRow(
            icon: Iconsax.call,
            label: AppTexts.contactPhone,
            value: phone ?? AppTexts.contactPhone,
            valueColor: AppColors.white,
          ),
          AppDetailRow(
            icon: Iconsax.sms,
            label: AppTexts.contactEmail,
            value: email ?? AppTexts.contactEmail,
            valueColor: AppColors.white,
          ),
          AppDetailRow(
            icon: Iconsax.location,
            label: AppTexts.contactLocation,
            value: location ?? AppTexts.contactLocation,
            valueColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
