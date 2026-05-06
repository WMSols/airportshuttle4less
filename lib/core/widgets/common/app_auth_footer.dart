import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

/// Reusable auth footer widget for Login and Register screens.
/// Displays a prompt with a link to navigate between auth screens.
/// Uses grey prompt and primary link for readability on light (white) backgrounds.
class AppAuthFooter extends StatefulWidget {
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
  State<AppAuthFooter> createState() => _AppAuthFooterState();
}

class _AppAuthFooterState extends State<AppAuthFooter> {
  late final TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = widget.onLinkTap;
  }

  @override
  void didUpdateWidget(covariant AppAuthFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onLinkTap != widget.onLinkTap) {
      _tapRecognizer.onTap = widget.onLinkTap;
    }
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = AppTextStyles.bodyText(
      context,
    ).copyWith(color: AppColors.white);

    return Padding(
      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02).copyWith(top: 0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '${widget.promptText} ', style: bodyStyle),
            TextSpan(
              text: widget.linkText,
              style: bodyStyle.copyWith(fontWeight: FontWeight.w600),
              recognizer: _tapRecognizer,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
