import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class AppHeroPreviewScreen extends StatelessWidget {
  const AppHeroPreviewScreen({
    super.key,
    required this.heroTag,
    required this.heroChild,
    this.title,
    this.subtitle,
    this.details,
  });

  final String heroTag;
  final Widget heroChild;
  final String? title;
  final String? subtitle;
  final List<Widget>? details;

  static Future<void> open(
    BuildContext context, {
    required String heroTag,
    required Widget heroChild,
    String? title,
    String? subtitle,
    List<Widget>? details,
  }) {
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) => AppHeroPreviewScreen(
          heroTag: heroTag,
          heroChild: heroChild,
          title: title,
          subtitle: subtitle,
          details: details,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxW = AppResponsive.screenWidth(context) * 0.92;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: ColoredBox(
                  color: AppColors.black.withValues(alpha: 0.45),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: heroTag,
                        transitionOnUserGestures: true,
                        child: Material(
                          color: Colors.transparent,
                          child: heroChild,
                        ),
                      ),
                      if (title != null || subtitle != null || details != null)
                        Container(
                          margin: EdgeInsets.only(
                            top: AppSpacing.verticalValue(context, 0.014),
                          ),
                          padding: AppSpacing.all(context),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                              AppResponsive.radius(context),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (title != null)
                                Text(
                                  title!,
                                  style: AppTextStyles.heading(context)
                                      .copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              if (subtitle != null)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppSpacing.verticalValue(
                                      context,
                                      0.006,
                                    ),
                                  ),
                                  child: Text(
                                    subtitle!,
                                    style: AppTextStyles.bodyText(context)
                                        .copyWith(
                                          color: AppColors.black.withValues(
                                            alpha: 0.8,
                                          ),
                                        ),
                                  ),
                                ),
                              if (details != null && details!.isNotEmpty) ...[
                                SizedBox(
                                  height: AppSpacing.verticalValue(
                                    context,
                                    0.01,
                                  ),
                                ),
                                ...details!,
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppHeroTapTarget extends StatelessWidget {
  const AppHeroTapTarget({
    super.key,
    required this.heroTag,
    required this.child,
    this.previewChild,
    this.previewTitle,
    this.previewSubtitle,
    this.previewDetails,
    this.borderRadius,
  });

  final String heroTag;
  final Widget child;
  final Widget? previewChild;
  final String? previewTitle;
  final String? previewSubtitle;
  final List<Widget>? previewDetails;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius =
        borderRadius ?? BorderRadius.circular(AppResponsive.radius(context));
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radius,
        onTap: () {
          AppHeroPreviewScreen.open(
            context,
            heroTag: heroTag,
            heroChild: previewChild ?? child,
            title: previewTitle,
            subtitle: previewSubtitle,
            details: previewDetails,
          );
        },
        child: Hero(
          tag: heroTag,
          transitionOnUserGestures: true,
          child: Material(color: Colors.transparent, child: child),
        ),
      ),
    );
  }
}
