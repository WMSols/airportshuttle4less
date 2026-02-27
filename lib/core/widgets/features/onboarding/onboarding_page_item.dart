import 'package:flutter/material.dart';

/// Data for a single onboarding page.
class OnboardingPage {
  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

/// Displays the image portion of an onboarding page (fills the white top area).
class OnboardingPageItem extends StatelessWidget {
  const OnboardingPageItem({
    super.key,
    required this.page,
    required this.pageIndex,
  });

  final OnboardingPage page;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      page.image,
      fit: BoxFit.contain,
      width: double.infinity,
    );
  }
}
