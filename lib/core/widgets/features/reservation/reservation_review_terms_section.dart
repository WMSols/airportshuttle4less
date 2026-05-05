import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/form/app_checkbox/app_checkbox.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_payment_info_controller.dart';

/// Review and terms acceptance for Payment Info step.
class ReservationReviewTermsSection extends StatefulWidget {
  const ReservationReviewTermsSection({
    super.key,
    required this.flow,
    required this.controller,
  });

  final ReservationFlowController flow;
  final ReservationPaymentInfoController controller;

  @override
  State<ReservationReviewTermsSection> createState() =>
      _ReservationReviewTermsSectionState();
}

class _ReservationReviewTermsSectionState
    extends State<ReservationReviewTermsSection> {
  late final TapGestureRecognizer _termsTap;
  late final TapGestureRecognizer _privacyTap;

  @override
  void initState() {
    super.initState();
    _termsTap = TapGestureRecognizer()
      ..onTap = () => _openUrl(HomeConstants.legalTermsUrl);
    _privacyTap = TapGestureRecognizer()
      ..onTap = () => _openUrl(HomeConstants.legalPrivacyUrl);
  }

  @override
  void dispose() {
    _termsTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacing.vertical(context, 0.004),
        Obx(
          () => AppCheckbox(
            value: widget.flow.acceptTerms.value,
            onChanged: widget.controller.setTermsAccepted,
            richLabel: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyText(
                  context,
                ).copyWith(color: AppColors.black, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: AppTexts.termsAcceptance),
                  TextSpan(
                    text: AppTexts.termsAndConditions,
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.primary),
                    recognizer: _termsTap,
                  ),
                  TextSpan(text: AppTexts.andLabel),
                  TextSpan(
                    text: AppTexts.privacyPolicy,
                    style: AppTextStyles.bodyText(
                      context,
                    ).copyWith(color: AppColors.primary),
                    recognizer: _privacyTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
