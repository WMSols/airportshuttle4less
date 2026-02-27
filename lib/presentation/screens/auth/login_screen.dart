import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/login_controller.dart';
import '../../../core/utils/app_colors/app_colors.dart';
import '../../../core/utils/app_responsive/app_responsive.dart';
import '../../../core/utils/app_spacing/app_spacing.dart';
import '../../../core/utils/app_styles/app_text_styles.dart';

/// Login screen for user authentication
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.padding(context, multiplier: 1.3),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSpacing.vertical(context, 0.06),
                // Logo/Header
                Icon(
                  Icons.directions_car,
                  size: AppResponsive.scaleSize(context, 80),
                  color: AppColors.primary,
                ),
                AppSpacing.vertical(context, 0.02),
                Text(
                  'AirportShuttles4Less',
                  style: AppTextStyles.headline(context).copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.vertical(context, 0.01),
                Text(
                  'Sign in to continue',
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.vertical(context, 0.06),
                // Email field
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.vertical(context, 0.02),
                // Password field
                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  validator: controller.validatePassword,
                  textInputAction: TextInputAction.done,
                )),
                AppSpacing.vertical(context, 0.02),
                // Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (_) => controller.toggleRememberMe(),
                      activeColor: AppColors.primary,
                    )),
                    Text(
                      'Remember me',
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                AppSpacing.vertical(context, 0.02),
                // Login button
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppResponsive.radius(context),
                      ),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: AppResponsive.buttonLoaderSize(context),
                          width: AppResponsive.buttonLoaderSize(context),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : const Text('Sign In'),
                )),
                AppSpacing.vertical(context, 0.02),
                // Forgot password
                TextButton(
                  onPressed: controller.navigateToForgotPassword,
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                AppSpacing.vertical(context, 0.03),
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTextStyles.bodyText(context).copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.navigateToRegister,
                      child: Text(
                        'Sign Up',
                        style: AppTextStyles.bodyText(context).copyWith(
                          color: AppColors.primary,
                        ),
                      ),
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
