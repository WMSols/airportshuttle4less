import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../routes/app_routes.dart';

/// Profile screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarSize = AppResponsive.scaleSize(context, 100);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTextStyles.heading(context).copyWith(
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.padding(context, multiplier: 1.3),
        child: Column(
          children: [
            // Profile Avatar
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: AppResponsive.scaleSize(context, 50),
                color: AppColors.primary,
              ),
            ),
            AppSpacing.vertical(context, 0.015),
            Text(
              'John Doe',
              style: AppTextStyles.headline(context).copyWith(
                color: AppColors.black,
              ),
            ),
            AppSpacing.vertical(context, 0.04),
            // Menu Items
            _MenuItem(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => Get.toNamed(AppRoutes.editProfile),
            ),
            _MenuItem(
              icon: Icons.history,
              title: 'Booking History',
              onTap: () => Get.toNamed(AppRoutes.myBookings),
            ),
            _MenuItem(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: () {},
            ),
            _MenuItem(
              icon: Icons.help_outline,
              title: 'FAQs',
              onTap: () => Get.toNamed(AppRoutes.faqs),
            ),
            _MenuItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {},
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? AppColors.error : AppColors.primary,
        size: AppResponsive.iconSize(context),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyText(context).copyWith(
          fontWeight: FontWeight.w500,
          color: isLogout ? AppColors.error : AppColors.black,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.grey,
        size: AppResponsive.iconSize(context),
      ),
      onTap: onTap,
    );
  }
}
