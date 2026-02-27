import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/features/onboarding/onboarding_bottom_panel.dart';
import 'package:airportshuttle4less/core/widgets/features/onboarding/onboarding_page_item.dart';
import 'package:airportshuttle4less/presentation/controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: AppImages.onboarding1,
      title: AppTexts.onBoardingTitle1,
      subtitle: AppTexts.onBoardingSubtitle1,
    ),
    OnboardingPage(
      image: AppImages.onboarding2,
      title: AppTexts.onBoardingTitle2,
      subtitle: AppTexts.onBoardingSubtitle2,
    ),
    OnboardingPage(
      image: AppImages.onboarding3,
      title: AppTexts.onBoardingTitle3,
      subtitle: AppTexts.onBoardingSubtitle3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OnboardingController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top white area — image carousel
            Expanded(
              child: PageView.builder(
                controller: c.pageController,
                onPageChanged: (i) => c.currentPage.value = i,
                itemCount: _pages.length,
                itemBuilder: (_, i) =>
                    OnboardingPageItem(page: _pages[i], pageIndex: i),
              ),
            ),

            // Bottom gradient panel — text, buttons, dots
            Obx(
              () => OnboardingBottomPanel(
                page: _pages[c.currentPage.value],
                pageCount: _pages.length,
                currentIndex: c.currentPage.value,
                isLastPage: c.currentPage.value == _pages.length - 1,
                onNext: c.nextPage,
                onSkip: c.skip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
