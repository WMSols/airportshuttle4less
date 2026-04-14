import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_read_more_link_text.dart';

class AppMarketingImageTile extends StatelessWidget {
  const AppMarketingImageTile({
    super.key,
    required this.title,
    required this.imageAsset,
    this.badgeOnLeft = true,
    this.badgeBackgroundColor = AppColors.primary,
    this.badgeTextColor = AppColors.white,
    this.maxTitleLines = 2,
    this.ellipsisTitle = true,
  });

  final String title;
  final String imageAsset;
  final bool badgeOnLeft;
  final Color badgeBackgroundColor;
  final Color badgeTextColor;
  final int maxTitleLines;
  final bool ellipsisTitle;

  @override
  Widget build(BuildContext context) {
    final r = AppResponsive.radius(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                ColoredBox(color: AppColors.primary.withValues(alpha: 0.15)),
          ),
          Positioned(
            left: badgeOnLeft
                ? AppSpacing.horizontalValue(context, 0.02)
                : null,
            right: badgeOnLeft
                ? null
                : AppSpacing.horizontalValue(context, 0.02),
            top: AppSpacing.verticalValue(context, 0.01),
            child: Container(
              decoration: BoxDecoration(
                color: badgeBackgroundColor,
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context),
                ),
              ),
              padding: AppSpacing.symmetric(context, h: 0.02, v: 0.005),
              child: Text(
                title,
                maxLines: maxTitleLines,
                overflow: ellipsisTitle ? TextOverflow.ellipsis : null,
                softWrap: true,
                style: AppTextStyles.bodyText(context).copyWith(
                  color: badgeTextColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.primaryFont,
                  fontSize: AppResponsive.scaleSize(context, 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppMarketingPreviewCard extends StatelessWidget {
  const AppMarketingPreviewCard({
    super.key,
    required this.imageAsset,
    this.title,
    this.description,
    this.readMoreLabel,
    this.readMoreUrl,
    this.isDark = false,
    this.imageAspectRatio = 2.2,
  });

  final String imageAsset;
  final String? title;
  final String? description;
  final String? readMoreLabel;
  final String? readMoreUrl;
  final bool isDark;
  final double imageAspectRatio;

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? AppColors.black : AppColors.white;
    final titleColor = isDark ? AppColors.white : AppColors.black;
    final bodyColor = isDark
        ? AppColors.white.withValues(alpha: 0.7)
        : AppColors.black.withValues(alpha: 0.85);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: ColoredBox(
        color: bg,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: imageAspectRatio,
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
              ),
              if (title != null || description != null || readMoreUrl != null)
                Padding(
                  padding: AppSpacing.all(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title!,
                          style: AppTextStyles.bodyText(context).copyWith(
                            color: titleColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      if (description != null) ...[
                        AppSpacing.vertical(context, 0.01),
                        Text(
                          description!,
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(color: bodyColor),
                        ),
                      ],
                      if (readMoreUrl != null && readMoreLabel != null) ...[
                        AppSpacing.vertical(context, 0.012),
                        AppReadMoreLinkText(
                          label: readMoreLabel!,
                          url: readMoreUrl!,
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
