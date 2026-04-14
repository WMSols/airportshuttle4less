import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';

/// Forgot password screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    final args = Get.arguments;
    if (args is Map && args['email'] != null) {
      _emailController.text = args['email'].toString();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final authUseCase = Get.find<AuthUseCase>();
      await authUseCase.forgotPassword(_emailController.text.trim());
      if (!mounted) return;
      setState(() => _isLoading = false);
      AppToast.showSuccess(AppTexts.success, AppTexts.resetLinkSent);
      Get.back();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      AppToast.showError(AppTexts.error, AppTexts.couldNotSendResetLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fixed full-screen background (does not move with keyboard)
        Positioned.fill(
          child: AppCustomBackground(child: const SizedBox.shrink()),
        ),
        // Content can move with keyboard (form)
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppCustomAppBar(title: '', isBack: true),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: AppSpacing.padding(context, multiplier: 1.3),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppTexts.appName,
                      style: AppTextStyles.bodyText(
                        context,
                      ).copyWith(fontFamily: AppFonts.tertiaryFont),
                    ),
                    Text(
                      AppTexts.forgotPasswordTitle,
                      style: AppTextStyles.headline(
                        context,
                      ).copyWith(fontFamily: AppFonts.tertiaryFont),
                    ),
                    AppSpacing.vertical(context, 0.01),
                    Text(
                      AppTexts.forgotPasswordSubtitle,
                      style: AppTextStyles.hintText(
                        context,
                      ).copyWith(color: AppColors.black),
                    ),
                    AppSpacing.vertical(context, 0.03),
                    AppTextField(
                      controller: _emailController,
                      label: AppTexts.email,
                      hint: AppTexts.enterEmail,
                      prefixIcon: Iconsax.sms,
                      validator: AppValidators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    AppSpacing.vertical(context, 0.03),
                    AppButton(
                      label: AppTexts.resetPassword,
                      onPressed: _submit,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
