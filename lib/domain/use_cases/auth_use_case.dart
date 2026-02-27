import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Auth use case for authentication operations
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  /// Login with email and password
  Future<User> login({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }

  /// Register a new user
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    bool isCorporate = false,
    String? corporateName,
  }) {
    return _repository.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      isCorporate: isCorporate,
      corporateName: corporateName,
    );
  }

  /// Logout current user
  Future<void> logout() {
    return _repository.logout();
  }

  /// Get current logged in user
  Future<User?> getCurrentUser() {
    return _repository.getCurrentUser();
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() {
    return _repository.isLoggedIn();
  }

  /// Save remember me preference
  Future<void> rememberMe(bool value) {
    return _repository.saveRememberMe(value);
  }

  /// Get remember me preference
  Future<bool> getRememberMe() {
    return _repository.getRememberMe();
  }

  /// Save onboarding completed status
  Future<void> onboardingCompleted(bool value) {
    return _repository.saveOnboardingCompleted(value);
  }

  /// Check if onboarding is completed
  Future<bool> isOnboardingCompleted() {
    return _repository.isOnboardingCompleted();
  }

  /// Forgot password - send reset email
  Future<void> forgotPassword(String email) {
    return _repository.forgotPassword(email);
  }

  /// Verify OTP code
  Future<bool> verifyOtp(String email, String otp) {
    return _repository.verifyOtp(email, otp);
  }

  /// Reset password
  Future<void> resetPassword(String email, String newPassword) {
    return _repository.resetPassword(email, newPassword);
  }

  /// Update user profile
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  }) {
    return _repository.updateProfile(
      name: name,
      phone: phone,
      profileImage: profileImage,
    );
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
