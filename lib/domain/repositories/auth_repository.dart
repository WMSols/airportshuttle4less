import '../entities/user.dart';

/// Auth repository interface defining authentication operations
abstract class AuthRepository {
  /// Login with email/phone and password
  Future<User> login({
    required String email,
    required String password,
  });

  /// Register a new user account
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    bool isCorporate = false,
    String? corporateName,
  });

  /// Logout current user
  Future<void> logout();

  /// Get current logged in user
  Future<User?> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Save remember me preference
  Future<void> saveRememberMe(bool value);

  /// Get remember me preference
  Future<bool> getRememberMe();

  /// Save onboarding completed status
  Future<void> saveOnboardingCompleted(bool value);

  /// Check if onboarding is completed
  Future<bool> isOnboardingCompleted();

  /// Forgot password - send reset email
  Future<void> forgotPassword(String email);

  /// Verify OTP code
  Future<bool> verifyOtp(String email, String otp);

  /// Reset password with new password
  Future<void> resetPassword(String email, String newPassword);

  /// Update user profile
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Refresh token
  Future<String> refreshToken(String refreshToken);
}
