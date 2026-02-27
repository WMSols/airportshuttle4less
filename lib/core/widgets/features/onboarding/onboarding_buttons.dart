import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';

/// Renders the action buttons for the onboarding screen.
///
/// - On non-last pages: [Next] (outlined) and [Skip] (filled) side by side.
/// - On the last page: a single full-width [Get Started] button.
class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    if (isLastPage) {
      return SizedBox(
        width: double.infinity,
        child: AppButton(
          label: AppTexts.getStarted,
          onPressed: onNext,
          backgroundColor: AppColors.secondary,
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: AppButton(
            label: AppTexts.next,
            onPressed: onNext,
            backgroundColor: AppColors.secondary,
          ),
        ),
        AppSpacing.horizontal(context, 0.04),
        Expanded(
          child: AppButton(
            label: AppTexts.skip,
            onPressed: onSkip,
            primary: false,
            showBorder: false,
          ),
        ),
      ],
    );
  }
}
