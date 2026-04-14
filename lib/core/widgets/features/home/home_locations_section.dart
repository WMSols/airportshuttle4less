import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_dots_indicator.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class HomeLocationsSection extends GetView<HomeController> {
  const HomeLocationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final r = AppResponsive.radius(context);
    final slideHeight = AppResponsive.screenHeight(context) * 0.24;
    final slides = HomeConstants.locationSlides;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeading(title: AppTexts.homeLocationsTitle),
        ClipRRect(
          borderRadius: BorderRadius.circular(r),
          child: SizedBox(
            height: slideHeight,
            width: double.infinity,
            child: PageView.builder(
              controller: c.locationPageController,
              onPageChanged: c.onLocationPageChanged,
              itemCount: slides.length,
              itemBuilder: (context, i) {
                final slide = slides[i];
                return _LocationSlide(
                  label: slide.label,
                  imageAsset: slide.imageAsset,
                  onTap: () => c.openLocationUrl(slide.url),
                );
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AppTextButton(
            label: AppTexts.homeViewAllLocations,
            onPressed: () => Get.toNamed(AppRoutes.allLocations),
          ),
        ),
        Obx(
          () => AppDotsIndicator(
            count: slides.length,
            currentIndex: c.locationPageIndex.value,
            activeDotSize: AppResponsive.scaleSize(context, 80),
            inactiveDotSize: AppResponsive.scaleSize(context, 8),
          ),
        ),
      ],
    );
  }
}

class _LocationSlide extends StatelessWidget {
  const _LocationSlide({
    required this.label,
    required this.imageAsset,
    required this.onTap,
  });

  final String label;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  ColoredBox(color: AppColors.lightGrey),
            ),
            Positioned(
              left: AppSpacing.horizontalValue(context, 0.02),
              top: AppSpacing.verticalValue(context, 0.01),
              child: Container(
                padding: AppSpacing.symmetric(context, h: 0.02, v: 0.005),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    AppResponsive.radius(context),
                  ),
                ),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppFonts.primaryFont,
                    fontSize: AppResponsive.scaleSize(context, 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
