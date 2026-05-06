import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/auth/auth_role.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for registration screen.
/// TextEditingControllers are owned by [RegisterScreen] and injected via [setTextControllers].
class RegisterController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController corporateNameController;
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final authRole = AuthRole.standardUser.obs;
  bool get isCorporate => authRole.value == AuthRole.corporate;

  /// Called by [RegisterScreen] so the controller uses widget-owned controllers.
  /// Must be called before the form is built.
  void setTextControllers({
    required TextEditingController name,
    required TextEditingController email,
    required TextEditingController phone,
    required TextEditingController password,
    required TextEditingController confirmPassword,
    required TextEditingController corporateName,
  }) {
    nameController = name;
    emailController = email;
    phoneController = phone;
    passwordController = password;
    confirmPasswordController = confirmPassword;
    corporateNameController = corporateName;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void setAuthRole(AuthRole role) {
    authRole.value = role;
  }

  String? validateName(String? value) =>
      AppValidators.validateRequiredName(value);

  String? validateEmail(String? value) => AppValidators.validateEmail(value);

  String? validatePhone(String? value) => AppValidators.validatePhone(value);

  String? validatePassword(String? value) =>
      AppValidators.validatePassword(value);

  String? validateConfirmPassword(String? value) =>
      AppValidators.validateConfirmPassword(value, passwordController.text);

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final displayName = isCorporate
          ? corporateNameController.text.trim()
          : nameController.text.trim();
      await _authUseCase.register(
        name: displayName,
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
        role: authRole.value,
        corporateName: isCorporate ? corporateNameController.text.trim() : null,
      );

      Get.offAllNamed(
        AppRoutes.login,
        arguments: {
          AuthRoleArgs.roleKey: AuthRoleArgs.routeValue(authRole.value),
        },
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppToast.showSuccess(AppTexts.success, AppTexts.registrationSuccess);
      });
    } catch (e) {
      AppToast.showError(AppTexts.error, AppTexts.registrationFailed);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToLogin() {
    Get.toNamed(
      AppRoutes.login,
      arguments: {
        AuthRoleArgs.roleKey: AuthRoleArgs.routeValue(authRole.value),
      },
    );
  }

  /// TextEditingControllers are owned and disposed by [RegisterScreen].
  @override
  void onClose() => super.onClose();
}
