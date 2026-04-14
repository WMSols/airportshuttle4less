import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/common/app_auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/features/auth/auth_register_form.dart';
import 'package:airportshuttle4less/presentation/controllers/auth/register_controller.dart';

/// Register screen for new user signup.
/// Owns [TextEditingController]s and injects them into [RegisterController] so
/// lifecycle is tied to the widget and not GetX route disposal.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _corporateNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _corporateNameController = TextEditingController();
    Get.find<RegisterController>().setTextControllers(
      name: _nameController,
      email: _emailController,
      phone: _phoneController,
      password: _passwordController,
      confirmPassword: _confirmPasswordController,
      corporateName: _corporateNameController,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _corporateNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterController>();

    return Stack(
      children: [
        // Fixed full-screen background (does not move with keyboard)
        Positioned.fill(
          child: AppCustomBackground(child: const SizedBox.shrink()),
        ),
        // Content can move with keyboard (form, footer)
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppCustomAppBar(title: '', isBack: true),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
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
                          AppTexts.signUp,
                          style: AppTextStyles.headline(
                            context,
                          ).copyWith(fontFamily: AppFonts.tertiaryFont),
                        ),
                        AppSpacing.vertical(context, 0.03),
                        const AuthRegisterForm(),
                        AppSpacing.vertical(context, 0.03),
                        Obx(
                          () => AppButton(
                            label: AppTexts.signUp,
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.register,
                            isLoading: controller.isLoading.value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppAuthFooter(
                  promptText: AppTexts.alreadyHaveAccount,
                  linkText: AppTexts.login,
                  onLinkTap: controller.navigateToLogin,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
