import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.bookingDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Status
            Container(
              padding: AppSpacing.all(context),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: borderRadius,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: AppResponsive.iconSize(context),
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.bookingReference,
                        style: AppTextStyles.hintText(context).copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'ASL-123456',
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: AppSpacing.symmetric(context, h: 0.03, v: 0.008),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context, factor: 2),
                      ),
                    ),
                    child: Text(
                      AppTexts.confirmed,
                      style: AppTextStyles.hintText(context).copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.vertical(context, 0.02),

            // Trip Details
            Text(
              'Trip Details',
              style: AppTextStyles.heading(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.vertical(context, 0.015),

            // Pickup
            _buildLocationRow(
              context: context,
              icon: Icons.trip_origin,
              iconColor: AppColors.success,
              title: 'Pickup',
              address: '123 Main Street, New York, NY 10001',
              time: 'Feb 25, 2026 - 10:00 AM',
            ),
            AppSpacing.vertical(context, 0.015),

            // Dropoff
            _buildLocationRow(
              context: context,
              icon: Icons.location_on,
              iconColor: AppColors.error,
              title: 'Drop-off',
              address: 'JFK International Airport, New York, NY 11430',
              time: 'Feb 25, 2026 - 11:00 AM',
            ),
            AppSpacing.vertical(context, 0.02),

            // Vehicle Info
            Container(
              padding: AppSpacing.all(context),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: borderRadius,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: AppColors.primary,
                    size: AppResponsive.scaleSize(context, 40),
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Standard Sedan',
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '3 Passengers',
                        style: AppTextStyles.hintText(context).copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.vertical(context, 0.02),

            // Price Details
            Text(
              'Price Details',
              style: AppTextStyles.heading(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.vertical(context, 0.015),

            Container(
              padding: AppSpacing.all(context),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: borderRadius,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price per person',
                          style: AppTextStyles.bodyText(context)),
                      Text('\$25.00', style: AppTextStyles.bodyText(context)),
                    ],
                  ),
                  AppSpacing.vertical(context, 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Passengers',
                          style: AppTextStyles.bodyText(context)),
                      Text('3', style: AppTextStyles.bodyText(context)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$75.00',
                        style: AppTextStyles.bodyText(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String address,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: AppResponsive.iconSize(context)),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyText(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                address,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                time,
                style: AppTextStyles.hintText(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
