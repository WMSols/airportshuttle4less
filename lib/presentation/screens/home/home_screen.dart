import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../routes/app_routes.dart';

/// Home screen - main booking screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Book a Ride',
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.padding(context, multiplier: 1.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Where would you like to go?',
                style: AppTextStyles.heading(context).copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              // Pickup Location Card
              _LocationCard(
                icon: Icons.location_on,
                title: 'Pickup Location',
                subtitle: 'Enter pickup address',
                onTap: () {},
              ),
              AppSpacing.vertical(context, 0.015),
              // Dropoff Location Card
              _LocationCard(
                icon: Icons.location_on_outlined,
                title: 'Drop-off Location',
                subtitle: 'Enter destination address',
                onTap: () {},
              ),
              AppSpacing.vertical(context, 0.03),
              // Search Rides Button
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.searchRide),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: AppSpacing.symmetric(context, h: 0.04, v: 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppResponsive.radius(context),
                    ),
                  ),
                ),
                child: Text(
                  'Search Rides',
                  style: AppTextStyles.bodyText(context).copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LocationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppSpacing.all(context),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: AppSpacing.all(context, factor: 0.5),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppResponsive.iconSize(context),
              ),
            ),
            AppSpacing.horizontal(context, 0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.hintText(context).copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  AppSpacing.vertical(context, 0.005),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyText(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.grey,
              size: AppResponsive.iconSize(context),
            ),
          ],
        ),
      ),
    );
  }
}
