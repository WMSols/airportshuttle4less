import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/widgets/common/app_read_more_link_text.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';
import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/profile_controller.dart';

/// Welcome block: reservation CTA, personalized title, hero image, body copy.
class HomeWelcomeSection extends StatelessWidget {
  const HomeWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<ProfileController>();
    final home = Get.find<HomeController>();
    final radius = AppResponsive.radius(context);
    final imageHeight = AppResponsive.screenHeight(context) * 0.32;

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton(
            label: AppTexts.homeBookReservation,
            icon: Iconsax.car,
            onPressed: home.openReservationTab,
          ),
          AppSpacing.vertical(context, 0.02),
          AppSectionHeading(
            title:
                '${AppTexts.homeWelcomeTitle} ${profile.user.value?.name.trim().toUpperCase()}!',
          ),
          AppHeroTapTarget(
            heroTag: HeroTags.homeWelcomeImage,
            borderRadius: BorderRadius.circular(radius),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(radius),
                top: Radius.circular(radius),
              ),
              child: SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Image.asset(
                  AppImages.homeWelcome,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: AppColors.primary.withValues(alpha: 0.08),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.vertical(context, 0.01),
          Text(
            AppTexts.homeWelcomeBody,
            textAlign: TextAlign.justify,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(color: AppColors.black, height: 1.2),
          ),
          const AppReadMoreLinkText(
            label: AppTexts.homeReadMoreWebsite,
            url: HomeConstants.site,
          ),
        ],
      ),
    );
  }
}
