import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

/// Reusable legal/static content section: title + body text (single or multiple paragraphs).
/// Uses [FaqSectionHeader]-style title and [AppTextStyles] for body.
class LegalContentSection extends StatelessWidget {
  const LegalContentSection({
    super.key,
    required this.title,
    required this.body,
    this.paragraphs,
  });

  /// Single body string (shown as one block). Ignored if [paragraphs] is provided.
  final String body;

  /// Section title (e.g. "1. Bookings").
  final String title;

  /// Optional list of paragraphs; if set, [body] is ignored.
  final List<String>? paragraphs;

  @override
  Widget build(BuildContext context) {
    final content = paragraphs != null && paragraphs!.isNotEmpty
        ? paragraphs!
              .map(
                (p) => Padding(
                  padding: EdgeInsets.only(
                    bottom: AppSpacing.verticalValue(context, 0.008),
                  ),
                  child: Text(
                    p,
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.black),
                  ),
                ),
              )
              .toList()
        : [
            Text(
              body,
              style: AppTextStyles.bodyText(
                context,
              ).copyWith(color: AppColors.black),
            ),
          ];

    return Padding(
      padding: AppSpacing.symmetric(context, h: 0, v: 0.012),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.primaryFont,
              fontSize: AppResponsive.screenWidth(context) * 0.04,
            ),
          ),
          AppSpacing.vertical(context, 0.008),
          ...content,
        ],
      ),
    );
  }
}
