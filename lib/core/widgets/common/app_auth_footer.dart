import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_text_button.dart';

/// Reusable auth footer widget for Login and Register screens.
/// Displays a prompt with a link to navigate between auth screens.
/// Uses grey prompt and primary link for readability on light (white) backgrounds.
class AppAuthFooter extends StatelessWidget {
  const AppAuthFooter({
    super.key,
    required this.promptText,
    required this.linkText,
    required this.onLinkTap,
  });

  /// The text displayed before the link (e.g., "Don't have an account?")
  final String promptText;

  /// The text for the clickable link (e.g., "Sign Up")
  final String linkText;

  /// Callback when the link is tapped
  final VoidCallback onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02).copyWith(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            promptText,
            style: AppTextStyles.bodyText(
              context,
            ).copyWith(color: AppColors.white),
          ),
          AppSpacing.horizontal(context, 0.005),
          AppTextButton(
            label: linkText,
            onPressed: onLinkTap,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
