import 'package:flutter/material.dart';

import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';

/// My Bookings screen
class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'My Bookings',
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: AppResponsive.scaleSize(context, 80),
              color: AppColors.grey,
            ),
            AppSpacing.vertical(context, 0.02),
            Text(
              'No bookings yet',
              style: AppTextStyles.heading(context).copyWith(
                color: AppColors.black,
              ),
            ),
            AppSpacing.vertical(context, 0.01),
            Text(
              'Your bookings will appear here',
              style: AppTextStyles.hintText(context).copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
