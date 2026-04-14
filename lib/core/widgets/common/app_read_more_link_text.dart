import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class AppReadMoreLinkText extends StatelessWidget {
  const AppReadMoreLinkText({
    super.key,
    required this.label,
    this.url,
    this.onTap,
  }) : assert(url != null || onTap != null, 'Provide url or onTap');

  final String label;
  final String? url;
  final VoidCallback? onTap;

  Future<void> _openUrl() async {
    if (url == null) return;
    final uri = Uri.parse(url!);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? _openUrl,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.hintText(context).copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: AppResponsive.scaleSize(context, 10),
              ),
            ),
          ),
          Icon(
            Iconsax.arrow_right_3,
            color: AppColors.primary,
            size: AppResponsive.iconSize(context, factor: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
