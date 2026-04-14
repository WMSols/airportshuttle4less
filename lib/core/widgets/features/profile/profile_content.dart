import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/features/profile/profile_avatar_section.dart';
import 'package:airportshuttle4less/core/widgets/features/profile/profile_menu_row.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_empty_widget.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/profile_controller.dart';

/// Profile body: avatar (name + member since), menu rows (Edit Profile, Forgot Password, FAQs), logout button.
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  /// Subtitle for Edit Profile row: show user details in one place.
  static String _editProfileSubtitle(String name, String email, String phone) {
    final parts = <String>[];
    if (name.isNotEmpty) parts.add(name);
    if (email.isNotEmpty) parts.add(email);
    if (phone.isNotEmpty) parts.add(phone);
    return parts.isEmpty ? '' : parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Padding(
            padding: AppSpacing.all(context, factor: 1.5),
            child: CircularProgressIndicator(),
          ),
        );
      }
      final user = controller.user.value;
      if (user == null) {
        return AppEmptyWidget(
          message: AppTexts.unableToLoadProfile,
          imagePath: AppImages.noDataYet,
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: ProfileAvatarSection(user: user)),
          AppSpacing.vertical(context, 0.04),
          ProfileMenuRow(
            icon: Iconsax.user_edit,
            title: AppTexts.editProfile,
            subtitle: _editProfileSubtitle(user.name, user.email, user.phone),
            onTap: controller.navigateToEditProfile,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.lock_1,
            title: AppTexts.forgotPasswordLabel,
            subtitle: user.email,
            onTap: () => controller.navigateToForgotPassword(user.email),
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.sms,
            title: AppTexts.contactUs,
            subtitle: AppTexts.contactUsSubtitle,
            onTap: controller.navigateToContactUs,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.building_4,
            title: AppTexts.corporateQuote,
            subtitle: AppTexts.corporateQuoteSubtitle,
            onTap: controller.navigateToCorporateQuote,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.message_question,
            title: AppTexts.faqs,
            subtitle: AppTexts.faqsSubtitle,
            onTap: controller.navigateToFaqs,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.message_text_1,
            title: AppTexts.reviews,
            subtitle: AppTexts.reviewsSubtitle,
            onTap: controller.navigateToReviews,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.document_text,
            title: AppTexts.termsAndConditions,
            subtitle: AppTexts.termsAndConditionsSubtitle,
            onTap: controller.navigateToTerms,
          ),
          AppSpacing.vertical(context, 0.02),
          ProfileMenuRow(
            icon: Iconsax.lock,
            title: AppTexts.privacyPolicy,
            subtitle: AppTexts.privacyPolicySubtitle,
            onTap: controller.navigateToPrivacy,
          ),
          AppSpacing.vertical(context, 0.04),
          Obx(
            () => AppButton(
              label: AppTexts.logout,
              onPressed:
                  controller.isLoading.value || controller.isLoggingOut.value
                  ? null
                  : controller.logout,
              isLoading: controller.isLoggingOut.value,
              backgroundColor: AppColors.black,
            ),
          ),
        ],
      );
    });
  }
}
