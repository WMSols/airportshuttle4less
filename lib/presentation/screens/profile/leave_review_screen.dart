import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/features/profile/leave_review_form.dart';

/// Leave Review screen: form to submit a comment via SaveComment API.
class LeaveReviewScreen extends StatelessWidget {
  const LeaveReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AppCustomBackground(
            isMain: true,
            child: const SizedBox.shrink(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppCustomAppBar(title: AppTexts.leaveReview, isBack: true),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: AppSpacing.symmetric(
                context,
                h: 0.04,
                v: 0.02,
              ),
              child: const LeaveReviewForm(),
            ),
          ),
        ),
      ],
    );
  }
}
