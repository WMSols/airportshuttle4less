import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/register_controller.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/buttons/app_text_button.dart';
import '../../../core/widgets/form/app_text_field/app_text_field.dart';

/// Register screen for new user signup
class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppResponsive.iconSize(context),
          ),
          onPressed: controller.navigateToLogin,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.padding(context, multiplier: 1.3),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: AppTextStyles.headline(context).copyWith(
                    color: AppColors.black,
                  ),
                ),
                AppSpacing.vertical(context, 0.01),
                Text(
                  'Sign up to get started',
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.grey,
                  ),
                ),
                AppSpacing.vertical(context, 0.03),
                // Name field
                AppTextField(
                  controller: controller.nameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefixIcon: Icons.person_outlined,
                  validator: controller.validateName,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.vertical(context, 0.02),
                // Email field
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.vertical(context, 0.02),
                // Phone field
                AppTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  validator: controller.validatePhone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.vertical(context, 0.02),
                // Password field
                AppTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  prefixIcon: Icons.lock_outlined,
                  obscureText: true,
                  validator: controller.validatePassword,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.vertical(context, 0.02),
                // Confirm Password field
                AppTextField(
                  controller: controller.confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Confirm your password',
                  prefixIcon: Icons.lock_outlined,
                  obscureText: true,
                  validator: controller.validateConfirmPassword,
                  textInputAction: TextInputAction.done,
                ),
                AppSpacing.vertical(context, 0.03),
                // Register button
                Obx(() => AppButton(
                  label: 'Sign Up',
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                )),
                AppSpacing.vertical(context, 0.02),
                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    AppTextButton(
                      label: 'Sign In',
                      onPressed: controller.navigateToLogin,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
