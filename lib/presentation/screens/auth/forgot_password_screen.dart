import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/forgot_password_controller.dart';

/// Forgot password screen
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    final args = Get.arguments;
    final useCustomBackground = args is Map
        ? (args['useCustomBackground'] as bool?) ?? true
        : true;

    final content = Scaffold(
      backgroundColor: useCustomBackground ? Colors.transparent : null,
      appBar: AppCustomAppBar(title: '', isBack: true),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: AppSpacing.padding(context, multiplier: 1.3),
          child: Form(
            key: controller.formKey,
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
                  style: AppTextStyles.heading(context).copyWith(
                    fontFamily: AppFonts.primaryFont,
                    fontWeight: FontWeight.w800,
                  ),
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
                  controller: controller.emailController,
                  label: AppTexts.email,
                  hint: AppTexts.enterEmail,
                  prefixIcon: Iconsax.sms,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                AppSpacing.vertical(context, 0.03),
                Obx(
                  () => AppButton(
                    label: AppTexts.resetPassword,
                    onPressed: controller.submit,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (!useCustomBackground) {
      return content;
    }

    return Stack(
      children: [
        // Fixed full-screen background (does not move with keyboard)
        Positioned.fill(
          child: AppCustomBackground(child: const SizedBox.shrink()),
        ),
        // Content can move with keyboard (form)
        content,
      ],
    );
  }
}
