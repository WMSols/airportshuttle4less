import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_images/app_images.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../domain/use_cases/auth_use_case.dart';
import '../../routes/app_routes.dart';

/// Splash screen with gradient background and animated logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
    _navigateToNext();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _navigateToNext() async {
    // Wait for animation to complete and a minimum display time
    await Future.delayed(const Duration(seconds: 2));

    // Check auth state and navigate accordingly
    final auth = Get.find<AuthUseCase>();
    final onboardingDone = await auth.isOnboardingCompleted();
    final loggedIn = await auth.isLoggedIn();

    if (!onboardingDone) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (!loggedIn) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      // Hydrate in-memory token so API interceptors can attach it to requests
      await auth.getCurrentUser();
      Get.offAllNamed(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    AppImages.appLogo,
                    width: AppResponsive.scaleSize(context, 180),
                    height: AppResponsive.scaleSize(context, 180),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
