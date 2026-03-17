import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for login screen.
/// TextEditingControllers are owned by [LoginScreen] and injected via [setTextControllers].
class LoginController extends GetxController {
  final AuthUseCase _authUseCase = Get.find<AuthUseCase>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final rememberMe = false.obs;
  final isPasswordVisible = false.obs;

  /// Called by [LoginScreen] so the controller uses widget-owned controllers.
  /// Must be called before the form is built.
  void setTextControllers({
    required TextEditingController email,
    required TextEditingController password,
  }) {
    emailController = email;
    passwordController = password;
  }

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final shouldRemember = await _authUseCase.getRememberMe();
    if (shouldRemember) {
      rememberMe.value = true;
      final email = await _authUseCase.getSavedEmail();
      final password = await _authUseCase.getSavedPassword();
      if (email != null && email.isNotEmpty) {
        emailController.text = email;
      }
      if (password != null && password.isNotEmpty) {
        passwordController.text = password;
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  String? validateEmail(String? value) => AppValidators.validateEmail(value);

  String? validatePassword(String? value) =>
      AppValidators.validatePassword(value);

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await _authUseCase.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (rememberMe.value) {
        await _authUseCase.rememberMe(true);
        await _authUseCase.saveSavedEmail(emailController.text.trim());
        await _authUseCase.saveSavedPassword(passwordController.text);
      } else {
        await _authUseCase.rememberMe(false);
      }

      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      AppToast.showError(AppTexts.error, AppTexts.invalidCredentials);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  void navigateToForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  /// TextEditingControllers are owned and disposed by [LoginScreen].
  @override
  void onClose() => super.onClose();
}
