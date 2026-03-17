import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';

/// Full-area background: white base plus blurred primary-colored glows.
/// When [isMain] is false: two containers (top-right circle and bottom-center).
/// When [isMain] is true: one container at top-center, same style as bottom-center.
/// Use with transparent Scaffold so the screen has a white background.
class AppCustomBackground extends StatelessWidget {
  const AppCustomBackground({
    super.key,
    required this.child,
    this.isMain = false,
  });

  final Widget child;

  /// When true, only one blur container is shown at top-center (same style as bottom-center).
  final bool isMain;

  @override
  Widget build(BuildContext context) {
    final topBlurSize = AppResponsive.scaleSize(context, 180);
    final topBlurRadius = AppResponsive.scaleSize(context, 120);
    final topSpreadRadius = AppResponsive.scaleSize(context, 80);
    final bottomBlurWidth = AppResponsive.screenWidth(context) * 1.0;
    final bottomBlurHeight = AppResponsive.scaleSize(context, 160);
    final bottomBlurRadius = AppResponsive.scaleSize(context, 120);
    final bottomSpreadRadius = AppResponsive.scaleSize(context, 100);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // White base so the screen has a solid background when Scaffold is transparent
        Positioned.fill(child: Container(color: AppColors.white)),
        if (isMain) ...[
          // Main screens: single top-center container, same style as bottom-center
          Positioned(
            left: (AppResponsive.screenWidth(context) - bottomBlurWidth) / 2,
            top: -topBlurSize * 0.7,
            child: IgnorePointer(
              child: Container(
                width: bottomBlurWidth,
                height: bottomBlurHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bottomBlurHeight),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.65),
                      blurRadius: topBlurRadius,
                      spreadRadius: topSpreadRadius,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ] else ...[
          // Top-right: container with blur and spread
          Positioned(
            top: -topBlurSize * 0.7,
            right: -topBlurSize * 0.4,
            child: IgnorePointer(
              child: Container(
                width: topBlurSize,
                height: topBlurSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.65),
                      blurRadius: topBlurRadius,
                      spreadRadius: topSpreadRadius,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom-center: container with blur and spread
          Positioned(
            left: (AppResponsive.screenWidth(context) - bottomBlurWidth) / 2,
            bottom: -bottomBlurHeight * 0.7,
            child: IgnorePointer(
              child: Container(
                width: bottomBlurWidth,
                height: bottomBlurHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bottomBlurHeight),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.65),
                      blurRadius: bottomBlurRadius,
                      spreadRadius: bottomSpreadRadius,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        child,
      ],
    );
  }
}
