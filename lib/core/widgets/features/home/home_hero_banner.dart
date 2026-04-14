import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final h = AppResponsive.screenHeight(context) * 0.2;
    final radius = AppResponsive.radius(context);

    final card = ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(radius),
        top: Radius.circular(radius),
      ),
      child: Image.asset(
        AppImages.homeBanner,
        fit: BoxFit.cover,
        height: h,
        width: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          height: h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.9),
                AppColors.black,
              ],
            ),
          ),
        ),
      ),
    );
    return AppHeroTapTarget(
      heroTag: HeroTags.homeHeroBanner,
      borderRadius: BorderRadius.circular(radius),
      previewChild: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          AppImages.homeBanner,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (_, __, ___) =>
              ColoredBox(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
      ),
      child: card,
    );
  }
}
