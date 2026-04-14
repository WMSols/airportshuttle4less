import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/form/app_checkbox/app_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/login_controller.dart';

/// Login form widget containing the email and password fields
class AuthLoginForm extends GetView<LoginController> {
  const AuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpacing.vertical(context, 0.06),
          // Email field - Using AppTextField
          AppTextField(
            controller: controller.emailController,
            label: AppTexts.email,
            hint: AppTexts.enterEmail,
            prefixIcon: Iconsax.sms,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          AppSpacing.vertical(context, 0.02),
          // Password field - Using AppTextField with visibility toggle
          Obx(
            () => AppTextField(
              controller: controller.passwordController,
              label: AppTexts.password,
              hint: AppTexts.enterPassword,
              prefixIcon: Iconsax.lock,
              obscureText: !controller.isPasswordVisible.value,
              suffixIcon: AppIconButton(
                icon: controller.isPasswordVisible.value
                    ? Iconsax.eye_slash
                    : Iconsax.eye,
                color: AppColors.white,
                backgroundColor: controller.isPasswordVisible.value
                    ? AppColors.black
                    : AppColors.primary,
                onPressed: controller.togglePasswordVisibility,
              ),
              // validator: controller.validatePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          // Remember me - Using AppCheckbox
          Obx(
            () => AppCheckbox(
              value: controller.rememberMe.value,
              onChanged: (_) => controller.toggleRememberMe(),
              label: AppTexts.rememberMe,
            ),
          ),
        ],
      ),
    );
  }
}
