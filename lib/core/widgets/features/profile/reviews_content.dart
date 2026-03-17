import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_empty_widget.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';
import 'package:airportshuttle4less/domain/entities/comment.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/reviews_controller.dart';

/// Reviews list and Leave review CTA. Uses [ReviewsController].
class ReviewsContent extends StatelessWidget {
  const ReviewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReviewsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return Padding(
              padding: AppSpacing.all(context, factor: 2),
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (controller.comments.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppEmptyWidget(
                  message: AppTexts.noReviewsYet,
                  imagePath: AppImages.noReviewsYet,
                ),
                AppSpacing.vertical(context, 0.03),
                AppButton(
                  label: AppTexts.leaveReview,
                  onPressed: controller.navigateToLeaveReview,
                  backgroundColor: AppColors.primary,
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...controller.comments.map(
                (c) => _CommentCard(
                  comment: c,
                  onDelete: () => controller.deleteComment(c.sid),
                  isDeleting: controller.isDeleting.value,
                ),
              ),
              AppSpacing.vertical(context, 0.02),
              AppButton(
                label: AppTexts.leaveReview,
                onPressed: controller.navigateToLeaveReview,
                backgroundColor: AppColors.primary,
              ),
            ],
          );
        }),
        AppSpacing.vertical(context, 0.02),
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onDelete;
  final bool isDeleting;

  const _CommentCard({
    required this.comment,
    required this.onDelete,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.all(context),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDetailRow(
            icon: Iconsax.message_question,
            label: comment.name,
            value: comment.comment,
            valueColor: AppColors.white,
          ),
          if (!isDeleting) ...[
            Align(
              alignment: Alignment.centerRight,
              child: AppIconButton(
                icon: Iconsax.trash,
                color: AppColors.white,
                backgroundColor: AppColors.error,
                onPressed: onDelete,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
