import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_dots_indicator.dart';
import 'package:airportshuttle4less/core/widgets/features/onboarding/onboarding_buttons.dart';
import 'package:airportshuttle4less/core/widgets/features/onboarding/onboarding_page_item.dart';

/// The bottom section of the onboarding screen.
///
/// Displays the current page's [title] and [subtitle], action buttons
/// ([OnboardingButtons]) and the [AppDotsIndicator].
class OnboardingBottomPanel extends StatelessWidget {
  const OnboardingBottomPanel({
    super.key,
    required this.page,
    required this.pageCount,
    required this.currentIndex,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  final OnboardingPage page;
  final int pageCount;
  final int currentIndex;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDotsIndicator(count: pageCount, currentIndex: currentIndex),
          AppSpacing.vertical(context, 0.02),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headline(context).copyWith(
              color: AppColors.black,
              fontFamily: AppFonts.tertiaryFont,
            ),
          ),
          AppSpacing.vertical(context, 0.012),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyText(context).copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
          AppSpacing.vertical(context, 0.03),
          OnboardingButtons(
            isLastPage: isLastPage,
            onNext: onNext,
            onSkip: onSkip,
          ),
        ],
      ),
    );
  }
}
