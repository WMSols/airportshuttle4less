import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/leave_review_controller.dart';

class LeaveReviewForm extends StatelessWidget {
  const LeaveReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeaveReviewController>();

    return Form(
      key: controller.formKey,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: controller.nameController,
              label: AppTexts.fullName,
              hint: AppTexts.enterFullName,
              prefixIcon: Iconsax.user,
              validator: AppValidators.validateRequiredName,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.messageController,
              label: AppTexts.message,
              hint: AppTexts.enterYourMessageHere,
              prefixIcon: Iconsax.message_question,
              maxLines: 5,
              minLines: 3,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.message),
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.emailController,
              label: AppTexts.email,
              hint: AppTexts.enterEmail,
              prefixIcon: Iconsax.sms,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.validateEmail,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.phoneController,
              label: AppTexts.mobileNumber,
              hint: AppTexts.enterYourMobileNumber,
              prefixIcon: Iconsax.call,
              keyboardType: TextInputType.phone,
              validator: AppValidators.validatePhone,
            ),
            AppSpacing.vertical(context, 0.01),
            AppDateDisplayField(
              label: AppTexts.reviewDate,
              value: controller.dateDisplay,
              placeholder: AppTexts.datePlaceholder,
              onTap: () => controller.openDatePicker(
                context,
                title: AppTexts.selectDate,
              ),
              required: true,
            ),
            AppSpacing.vertical(context, 0.02),
            AppButton(
              label: AppTexts.submitReview,
              onPressed: controller.isSubmitting.value
                  ? null
                  : () async {
                      if (controller.formKey.currentState?.validate() != true) {
                        return;
                      }
                      if (controller.selectedDate.value == null) {
                        AppToast.showError(
                          AppTexts.error,
                          AppTexts.pleaseFillRequiredFields,
                        );
                        return;
                      }
                      await controller.submit();
                    },
              isLoading: controller.isSubmitting.value,
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
