import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';

/// Read-only personal details list for Payment Info step.
class ReservationPersonalDetailsSection extends StatelessWidget {
  const ReservationPersonalDetailsSection({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
  });

  final String fullName;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.personalDetailsLabel,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.vertical(context, 0.01),
        AppDetailRow(
          icon: Iconsax.user,
          label: AppTexts.fullName,
          value: fullName.isEmpty ? '-' : fullName,
        ),
        AppSpacing.vertical(context, 0.01),
        AppDetailRow(
          icon: Iconsax.call,
          label: AppTexts.phoneNumber,
          value: phone.isEmpty ? '-' : phone,
        ),
        AppSpacing.vertical(context, 0.01),
        AppDetailRow(
          icon: Iconsax.sms,
          label: AppTexts.registeredEmail,
          value: email.isEmpty ? '-' : email,
        ),
      ],
    );
  }
}
