import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/features/contact/contact_info_section.dart';
import 'package:airportshuttle4less/core/widgets/form/app_sms_consent/app_sms_consent_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';

/// Contact form: contact info, Full Name, Mobile Number, Email, Message, SMS consent, SEND MESSAGE NOW.
/// Submits via EnquiryMail API.
class ContactUsContent extends StatefulWidget {
  const ContactUsContent({super.key});

  @override
  State<ContactUsContent> createState() => _ContactUsContentState();
}

class _ContactUsContentState extends State<ContactUsContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _smsConsent = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (!_smsConsent) {
      AppToast.showError(AppTexts.error, AppTexts.smsConsentRequired);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final useCase = Get.find<SupportUseCase>();
      final success = await useCase.sendEnquiry(
        name: _nameController.text.trim(),
        mobileNo: _mobileController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );
      if (!mounted) return;
      if (success) {
        Get.back();
        AppToast.showSuccess(AppTexts.success, AppTexts.messageSentSuccess);
      } else {
        AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
      }
    } catch (_) {
      if (!mounted) return;
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _nameController,
            label: AppTexts.fullName,
            hint: AppTexts.enterFullName,
            prefixIcon: Iconsax.user,
            validator: AppValidators.validateRequiredName,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _mobileController,
            label: AppTexts.mobileNumber,
            hint: AppTexts.enterYourMobileNumber,
            prefixIcon: Iconsax.call,
            keyboardType: TextInputType.phone,
            validator: AppValidators.validatePhone,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _emailController,
            label: AppTexts.email,
            hint: AppTexts.enterEmail,
            prefixIcon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _messageController,
            label: AppTexts.message,
            hint: AppTexts.enterYourMessageHere,
            prefixIcon: Iconsax.message_question,
            maxLines: 5,
            minLines: 3,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.message),
          ),
          AppSpacing.vertical(context, 0.02),
          AppSmsConsentCheckbox(
            value: _smsConsent,
            onChanged: (v) => setState(() => _smsConsent = v),
            consentText: AppTexts.smsConsentContact,
          ),
          AppSpacing.vertical(context, 0.02),
          AppButton(
            label: AppTexts.sendMessageNow,
            onPressed: _isSubmitting ? null : _onSubmit,
            isLoading: _isSubmitting,
            backgroundColor: AppColors.primary,
          ),
          AppSpacing.vertical(context, 0.02),
          const ContactInfoSection(),
        ],
      ),
    );
  }
}
