import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';

/// Bottom panel with a curved top edge and a gradient background
/// (primary → secondary). The panel auto-sizes based on child content.
class AppBottomPanelBackground extends StatelessWidget {
  const AppBottomPanelBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final topRadius = AppResponsive.radius(context, factor: 6);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        ),
      ),
      child: IntrinsicHeight(child: child),
    );
  }
}
