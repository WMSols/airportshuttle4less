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
import 'package:airportshuttle4less/presentation/controllers/home/all_services_controller.dart';

class AllServicesScreen extends GetView<AllServicesController> {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingH = AppSpacing.horizontalValue(context, 0.02);
    final spacingV = AppSpacing.verticalValue(context, 0.01);
    final services = controller.items;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(title: AppTexts.homeServicesTitle, isBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: spacingH,
              mainAxisSpacing: spacingV,
              childAspectRatio: 1.12,
            ),
            itemCount: services.length,
            itemBuilder: (context, i) {
              final item = services[i];
              return AppHeroTapTarget(
                heroTag: HeroTags.allServicesTile(i),
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
                previewChild: AppMarketingPreviewCard(
                  imageAsset: item.imageAsset,
                  title: item.title.toUpperCase(),
                  description: item.description,
                  readMoreLabel: item.readMoreLabel,
                  readMoreUrl: item.readMoreUrl,
                  isDark: item.darkPreview,
                ),
                child: AppMarketingImageTile(
                  title: item.title,
                  imageAsset: item.imageAsset,
                  badgeOnLeft: item.titleOnLeft,
                  ellipsisTitle: false,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
