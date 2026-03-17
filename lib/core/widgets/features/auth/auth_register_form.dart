import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/register_controller.dart';

/// Register form widget containing all the registration fields
class AuthRegisterForm extends GetView<RegisterController> {
  const AuthRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Name field - Using AppTextField
          AppTextField(
            controller: controller.nameController,
            label: AppTexts.fullName,
            hint: AppTexts.enterFullName,
            prefixIcon: Iconsax.user,
            validator: controller.validateName,
            textInputAction: TextInputAction.next,
          ),
          AppSpacing.vertical(context, 0.02),
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
          // Phone field - Using AppTextField
          AppTextField(
            controller: controller.phoneController,
            label: AppTexts.phoneNumber,
            hint: AppTexts.enterPhoneNumber,
            prefixIcon: Iconsax.call,
            validator: controller.validatePhone,
            keyboardType: TextInputType.phone,
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
              validator: controller.validatePassword,
              textInputAction: TextInputAction.next,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
          // Confirm Password field - Using AppTextField with visibility toggle
          Obx(
            () => AppTextField(
              controller: controller.confirmPasswordController,
              label: AppTexts.confirmPassword,
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
              validator: controller.validateConfirmPassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          AppSpacing.vertical(context, 0.02),
        ],
      ),
    );
  }
}
