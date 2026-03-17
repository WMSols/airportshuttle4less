import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';

class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.isBack = false,
    this.automaticallyImplyLeading = true,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool isBack;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize {
    if (bottom == null) return const Size.fromHeight(kToolbarHeight);
    return Size.fromHeight(kToolbarHeight + bottom!.preferredSize.height);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveLeading = isBack
        ? Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.horizontalValue(context, 0.04),
              top: AppSpacing.verticalValue(context, 0.02),
            ),
            child: AppIconButton(
              isBack: true,
              color: AppColors.white,
              backgroundColor: AppColors.primary,
            ),
          )
        : leading;
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.heading(
          context,
        ).copyWith(color: AppColors.black, fontWeight: FontWeight.w800),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      automaticallyImplyLeading: isBack ? false : automaticallyImplyLeading,
      leading: effectiveLeading,
      actions: actions,
      bottom: bottom,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      elevation: 0,
    );
  }
}
