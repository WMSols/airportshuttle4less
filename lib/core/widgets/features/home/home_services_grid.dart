import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_text_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_marketing_cards.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingH = AppSpacing.horizontalValue(context, 0.02);
    final spacingV = AppSpacing.verticalValue(context, 0.01);
    final tiles = HomeConstants.serviceTiles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeading(title: AppTexts.homeServicesTitle),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacingH,
            mainAxisSpacing: spacingV,
            childAspectRatio: 1.12,
          ),
          itemCount: tiles.length,
          itemBuilder: (context, i) {
            final item = tiles[i];
            final tile = AppMarketingImageTile(
              title: item.title,
              imageAsset: item.imageAsset,
              badgeOnLeft: item.titleOnLeft,
            );
            return AppHeroTapTarget(
              heroTag: HeroTags.homeServiceTile(i),
              borderRadius: BorderRadius.circular(
                AppResponsive.radius(context),
              ),
              previewChild: AppMarketingPreviewCard(
                imageAsset: item.imageAsset,
                title: item.title,
                description: item.description,
                readMoreLabel: item.readMoreLabel,
                readMoreUrl: item.readMoreUrl,
                isDark: item.darkPreview,
              ),
              child: tile,
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: AppTextButton(
            label: AppTexts.homeViewAllServices,
            onPressed: () => Get.toNamed(AppRoutes.allServices),
          ),
        ),
      ],
    );
  }
}
