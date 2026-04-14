import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_helper/app_helper.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/widgets/common/app_dots_indicator.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';
import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';

/// Preferred fleet carousel; call [AppIconButton] top-right; feature strip on black bar.
class HomePrefferedVehiclesSection extends GetView<HomeController> {
  const HomePrefferedVehiclesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final cardHeight = AppResponsive.screenHeight(context) * 0.32;
    final r = AppResponsive.radius(context);
    final vehicles = HomeConstants.preferredVehicles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeading(title: AppTexts.homePreferredVehiclesTitle),
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: c.preferredVehiclePageController,
            onPageChanged: c.onPreferredVehiclePageChanged,
            itemCount: vehicles.length,
            itemBuilder: (context, i) {
              final vehicle = vehicles[i];
              return AppHeroTapTarget(
                heroTag: HeroTags.homePreferredVehicle(i),
                borderRadius: BorderRadius.circular(r),
                previewTitle: vehicle.title.replaceAll('\n', ' '),
                previewSubtitle: AppTexts.homePreferredVehiclesTitle,
                previewDetails: vehicle.features
                    .map(
                      (f) => Padding(
                        padding: EdgeInsets.only(
                          bottom: AppSpacing.verticalValue(context, 0.006),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              f.icon,
                              color: AppColors.primary,
                              size: AppResponsive.iconSize(
                                context,
                                factor: 0.9,
                              ),
                            ),
                            AppSpacing.horizontal(context, 0.005),
                            Expanded(
                              child: Text(
                                '${f.icon.featureLabel}: ${f.value}',
                                style: AppTextStyles.bodyText(context).copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                child: _PreferredVehicleCard(
                  vehicle: vehicle,
                  borderRadius: r,
                  onCallTap: c.dialSupportPhone,
                ),
              );
            },
          ),
        ),
        AppSpacing.vertical(context, 0.01),
        Obx(
          () => AppDotsIndicator(
            count: vehicles.length,
            currentIndex: c.preferredVehiclePageIndex.value,
            activeDotSize: AppResponsive.scaleSize(context, 80),
            inactiveDotSize: AppResponsive.scaleSize(context, 8),
          ),
        ),
      ],
    );
  }
}

class _PreferredVehicleCard extends StatelessWidget {
  const _PreferredVehicleCard({
    required this.vehicle,
    required this.borderRadius,
    required this.onCallTap,
  });

  final HomePreferredVehicle vehicle;
  final double borderRadius;
  final Future<void> Function() onCallTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.horizontalValue(context, 0.02),
      ),
      child: SizedBox(
        height: AppResponsive.screenHeight(context) * 0.32,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: AppColors.black),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              vehicle.imageAsset,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Center(
                                child: Icon(
                                  Iconsax.car,
                                  size: AppResponsive.iconSize(
                                    context,
                                    factor: 3,
                                  ),
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            vehicle.title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyText(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontFamily: AppFonts.primaryFont,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: -1,
                      child: AppIconButton(
                        icon: Iconsax.call,
                        onPressed: () => onCallTap(),
                        backgroundColor: AppColors.black,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _FeatureStrip(features: vehicle.features),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureStrip extends StatelessWidget {
  const _FeatureStrip({required this.features});

  final List<HomePreferredVehicleFeature> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.radius(context)),
          topRight: Radius.circular(AppResponsive.radius(context)),
        ),
      ),
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
      child: Row(
        children: features.map((f) {
          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  f.icon,
                  color: AppColors.white,
                  size: AppResponsive.iconSize(context, factor: 0.9),
                ),
                AppSpacing.horizontal(context, 0.005),
                Flexible(
                  child: Text(
                    f.value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.hintText(context).copyWith(
                      color: AppColors.white,
                      height: 0.9,
                      fontWeight: FontWeight.w700,
                      fontSize: AppResponsive.scaleSize(context, 8),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
