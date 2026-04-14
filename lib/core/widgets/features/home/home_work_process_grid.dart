import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_tags/hero_tags.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_hero_preview_screen.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';

/// Two rows: [ large | small ], [ small | large ] — bento-style process steps.
class HomeWorkProcessGrid extends StatelessWidget {
  const HomeWorkProcessGrid({super.key});

  static const _largeFlex = 4;
  static const _smallFlex = 3;

  @override
  Widget build(BuildContext context) {
    final spacingH = AppSpacing.horizontalValue(context, 0.02);
    final spacingV = AppSpacing.verticalValue(context, 0.01);
    final cells = HomeConstants.processCells;

    final cell0 = cells[0];
    final cell1 = cells[1];
    final cell2 = cells[2];
    final cell3 = cells[3];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeading(title: AppTexts.homeProcessTitle),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: _largeFlex,
                child: _ProcessTile(
                  icon: cell0.icon,
                  label: cell0.label,
                  heroTag: HeroTags.homeWorkProcessTile(0),
                ),
              ),
              SizedBox(width: spacingH),
              Expanded(
                flex: _smallFlex,
                child: _ProcessTile(
                  icon: cell1.icon,
                  label: cell1.label,
                  heroTag: HeroTags.homeWorkProcessTile(1),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spacingV),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: _smallFlex,
                child: _ProcessTile(
                  icon: cell2.icon,
                  label: cell2.label,
                  heroTag: HeroTags.homeWorkProcessTile(2),
                ),
              ),
              SizedBox(width: spacingH),
              Expanded(
                flex: _largeFlex,
                child: _ProcessTile(
                  icon: cell3.icon,
                  label: cell3.label,
                  heroTag: HeroTags.homeWorkProcessTile(3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProcessTile extends StatelessWidget {
  const _ProcessTile({
    required this.icon,
    required this.label,
    required this.heroTag,
  });

  final IconData icon;
  final String label;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final tile = Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      ),
      child: Padding(
        padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppSpacing.all(context),
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: AppResponsive.iconSize(context, factor: 1.45),
              ),
            ),
            AppSpacing.vertical(context, 0.01),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyText(
                context,
              ).copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
    return AppHeroTapTarget(
      heroTag: heroTag,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: tile,
    );
  }
}
