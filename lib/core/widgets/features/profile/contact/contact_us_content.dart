import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/features/profile/contact/contact_info_section.dart';
import 'package:airportshuttle4less/core/widgets/form/app_sms_consent/app_sms_consent_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/contact_us_controller.dart';

/// Contact form: contact info, Full Name, Mobile Number, Email, Message, SMS consent, SEND MESSAGE NOW.
/// Submits via EnquiryMail API.
class ContactUsContent extends StatelessWidget {
  const ContactUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactUsController());
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: controller.nameController,
            label: AppTexts.fullName,
            hint: AppTexts.enterFullName,
            prefixIcon: Iconsax.user,
            validator: controller.validateName,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: controller.mobileController,
            label: AppTexts.mobileNumber,
            hint: AppTexts.enterYourMobileNumber,
            prefixIcon: Iconsax.call,
            keyboardType: TextInputType.phone,
            validator: controller.validatePhone,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: controller.emailController,
            label: AppTexts.email,
            hint: AppTexts.enterEmail,
            prefixIcon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            validator: controller.validateEmail,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: controller.messageController,
            label: AppTexts.message,
            hint: AppTexts.enterYourMessageHere,
            prefixIcon: Iconsax.message_question,
            maxLines: 5,
            minLines: 3,
            validator: controller.validateMessage,
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppSmsConsentCheckbox(
              value: controller.smsConsent.value,
              onChanged: controller.setSmsConsent,
              consentText: AppTexts.smsConsentContact,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppButton(
              label: AppTexts.sendMessageNow,
              onPressed: controller.submit,
              isLoading: controller.isSubmitting.value,
              backgroundColor: AppColors.primary,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          const ContactInfoSection(),
        ],
      ),
    );
  }
}
