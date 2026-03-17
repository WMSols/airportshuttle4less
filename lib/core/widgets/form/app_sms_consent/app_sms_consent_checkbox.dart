import 'package:airportshuttle4less/core/utils/app_texts/privacy_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// SMS consent checkbox with long text; "Privacy Policy" and "Terms & Conditions" open in-app screens.
class AppSmsConsentCheckbox extends StatelessWidget {
  const AppSmsConsentCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.consentText,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  /// Defaults to [AppTexts.smsConsentContact].
  final String? consentText;

  @override
  Widget build(BuildContext context) {
    final text = consentText ?? AppTexts.smsConsentContact;
    final linkStyle = AppTextStyles.bodyText(context).copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w500,
      fontFamily: AppFonts.primaryFont,
      decoration: TextDecoration.underline,
      fontSize: AppResponsive.screenWidth(context) * 0.032,
    );
    final bodyStyle = AppTextStyles.bodyText(context).copyWith(
      color: AppColors.black,
      fontSize: AppResponsive.screenWidth(context) * 0.032,
    );

    const privacyLabel = PrivacyTexts.privacyPolicyTitle;
    const termsLabel = PrivacyTexts.termsAndConditionsTitle;
    final spans = <TextSpan>[];
    int start = 0;
    while (start < text.length) {
      final privacyIdx = text.indexOf(privacyLabel, start);
      final termsIdx = text.indexOf(termsLabel, start);
      int nextLink = -1;
      String linkText = '';
      if (privacyIdx >= 0 && (termsIdx < 0 || privacyIdx <= termsIdx)) {
        nextLink = privacyIdx;
        linkText = privacyLabel;
      } else if (termsIdx >= 0) {
        nextLink = termsIdx;
        linkText = termsLabel;
      }
      if (nextLink < 0) {
        spans.add(TextSpan(text: text.substring(start), style: bodyStyle));
        break;
      }
      if (nextLink > start) {
        spans.add(
          TextSpan(text: text.substring(start, nextLink), style: bodyStyle),
        );
      }
      if (linkText == privacyLabel) {
        spans.add(
          TextSpan(
            text: privacyLabel,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.toNamed(AppRoutes.privacy),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: termsLabel,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.toNamed(AppRoutes.terms),
          ),
        );
      }
      start = nextLink + linkText.length;
    }

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Padding(
        padding: AppSpacing.symmetric(context, h: 0, v: 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppResponsive.iconSize(context),
              height: AppResponsive.iconSize(context),
              child: Checkbox(
                value: value,
                onChanged: (_) => onChanged(!value),
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppResponsive.radius(context) * 0.5,
                  ),
                ),
              ),
            ),
            AppSpacing.horizontal(context, 0.02),
            Expanded(
              child: RichText(text: TextSpan(children: spans)),
            ),
          ],
        ),
      ),
    );
  }
}
