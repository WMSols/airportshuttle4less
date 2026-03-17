import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Support screen
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AppCustomBackground(
            isMain: true,
            child: const SizedBox.shrink(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppCustomAppBar(
            title: 'Support',
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: AppSpacing.padding(context, multiplier: 1.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'How can we help you?',
                  style: AppTextStyles.heading(
                    context,
                  ).copyWith(color: AppColors.black),
                ),
                AppSpacing.vertical(context, 0.02),
                _SupportItem(
                  icon: Iconsax.message_question,
                  title: 'FAQs',
                  subtitle: 'Find answers to common questions',
                  onTap: () => Get.toNamed(AppRoutes.faqs),
                ),
                _SupportItem(
                  icon: Iconsax.sms,
                  title: 'Contact Us',
                  subtitle: 'Get in touch with our support team',
                  onTap: () => Get.toNamed(AppRoutes.contactUs),
                ),
                _SupportItem(
                  icon: Iconsax.building_4,
                  title: 'Corporate Quotes',
                  subtitle: 'Request a quote for your company',
                  onTap: () => Get.toNamed(AppRoutes.corporateQuote),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppSpacing.verticalValue(context, 0.015)),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        side: BorderSide(color: AppColors.grey.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Container(
          padding: AppSpacing.all(context, factor: 0.5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: AppResponsive.iconSize(context),
          ),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(fontWeight: FontWeight.w600, color: AppColors.black),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.hintText(
            context,
          ).copyWith(color: AppColors.grey),
        ),
        trailing: Icon(
          Iconsax.arrow_right_3,
          color: AppColors.grey,
          size: AppResponsive.iconSize(context),
        ),
        onTap: onTap,
      ),
    );
  }
}
