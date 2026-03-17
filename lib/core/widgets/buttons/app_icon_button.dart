import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.icon,
    this.onPressed,
    this.isBack = false,
    this.size,
    this.paddingFactor,
    this.color,
    this.backgroundColor,
  }) : assert(
         !isBack || icon == null,
         'When isBack is true, do not pass icon.',
       ),
       assert(
         isBack || icon != null,
         'When isBack is false, icon is required.',
       );

  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isBack;
  final double? size;
  final double? paddingFactor;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveIcon = isBack ? Iconsax.arrow_left_2 : icon!;
    final effectiveOnPressed = isBack ? () => Get.back() : onPressed;
    final iconSize = size ?? AppResponsive.iconSize(context);
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: InkWell(
        onTap: effectiveOnPressed,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
        child: Padding(
          padding: AppSpacing.all(context, factor: paddingFactor ?? 1),
          child: Icon(
            effectiveIcon,
            size: iconSize,
            color: color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
