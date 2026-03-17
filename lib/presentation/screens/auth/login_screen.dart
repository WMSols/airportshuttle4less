import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_text_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/features/auth/auth_login_form.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/login_controller.dart';

/// Login screen for user authentication.
/// Owns [TextEditingController]s and injects them into [LoginController] so
/// lifecycle is tied to the widget and not GetX route disposal.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    Get.find<LoginController>().setTextControllers(
      email: _emailController,
      password: _passwordController,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Stack(
      children: [
        // Fixed full-screen background (does not move with keyboard)
        Positioned.fill(
          child: AppCustomBackground(child: const SizedBox.shrink()),
        ),
        // Content can move with keyboard (form, footer)
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppSpacing.vertical(context, 0.06),
                        Center(
                          child: CircleAvatar(
                            radius: AppResponsive.scaleSize(context, 50),
                            backgroundColor: AppColors.black,
                            child: Padding(
                              padding: AppSpacing.all(context),
                              child: Image.asset(AppImages.appLogo),
                            ),
                          ),
                        ),
                        AppSpacing.vertical(context, 0.02),
                        Text(
                          AppTexts.appName,
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(fontFamily: AppFonts.tertiaryFont),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          AppTexts.login,
                          style: AppTextStyles.headline(
                            context,
                          ).copyWith(fontFamily: AppFonts.tertiaryFont),
                          textAlign: TextAlign.center,
                        ),
                        const AuthLoginForm(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AppTextButton(
                            label: AppTexts.forgotPassword,
                            onPressed: controller.navigateToForgotPassword,
                            textColor: AppColors.primary,
                          ),
                        ),
                        AppSpacing.vertical(context, 0.02),
                        Obx(
                          () => AppButton(
                            label: AppTexts.login,
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.login,
                            isLoading: controller.isLoading.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppAuthFooter(
                  promptText: AppTexts.dontHaveAccount,
                  linkText: AppTexts.signUp,
                  onLinkTap: controller.navigateToRegister,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
