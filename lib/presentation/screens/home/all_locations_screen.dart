import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';
import 'package:airportshuttle4less/core/widgets/common/app_marketing_cards.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/presentation/controllers/home/all_locations_controller.dart';

class AllLocationsScreen extends GetView<AllLocationsController> {
  const AllLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingH = AppSpacing.horizontalValue(context, 0.02);
    final spacingV = AppSpacing.verticalValue(context, 0.01);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(title: AppTexts.homeLocationsTitle, isBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => AppDropdownField<String>(
                  label: AppTexts.homeLocationsFilter,
                  value: controller.selectedScope.value,
                  items: controller.scopes,
                  onChanged: controller.setScope,
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: spacingH,
                    mainAxisSpacing: spacingV,
                    childAspectRatio: 1.12,
                  ),
                  itemCount: controller.items.length,
                  itemBuilder: (context, i) {
                    final item = controller.items[i];
                    return AppHeroTapTarget(
                      heroTag: HeroTags.allLocationsTile(
                        controller.selectedScope.value,
                        i,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                      previewChild: AppMarketingPreviewCard(
                        imageAsset: item.imageAsset,
                        readMoreLabel: AppTexts.homeReadMoreWebsite,
                        readMoreUrl: item.url,
                        imageAspectRatio: 1.5,
                      ),
                      child: AppMarketingImageTile(
                        title: item.label,
                        imageAsset: item.imageAsset,
                        badgeOnLeft: true,
                        badgeBackgroundColor: AppColors.white,
                        badgeTextColor: AppColors.black,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
