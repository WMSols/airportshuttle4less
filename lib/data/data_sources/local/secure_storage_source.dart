import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/constants/storage_keys.dart';

/// Secure storage wrapper for local data persistence
class SecureStorageSource {
  final FlutterSecureStorage _storage;

  SecureStorageSource({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: StorageKeys.userId, value: userId);
  }

  /// Get user ID
  Future<String?> getUserId() async {
    return await _storage.read(key: StorageKeys.userId);
  }

  /// Save user data as JSON string
  Future<void> saveUserData(String userJson) async {
    await _storage.write(key: StorageKeys.userData, value: userJson);
  }

  /// Get user data
  Future<String?> getUserData() async {
    return await _storage.read(key: StorageKeys.userData);
  }

  /// Save remember me preference
  Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: StorageKeys.rememberMe, value: value.toString());
  }

  /// Get remember me preference
  Future<bool> getRememberMe() async {
    final value = await _storage.read(key: StorageKeys.rememberMe);
    return value == 'true';
  }

  /// Save onboarding completed status
  Future<void> saveOnboardingCompleted(bool value) async {
    await _storage.write(key: StorageKeys.onboardingCompleted, value: value.toString());
  }

  /// Get onboarding completed status
  Future<bool> isOnboardingCompleted() async {
    final value = await _storage.read(key: StorageKeys.onboardingCompleted);
    return value == 'true';
  }

  /// Save email for remember me
  Future<void> saveSavedEmail(String email) async {
    await _storage.write(key: StorageKeys.savedEmail, value: email);
  }

  /// Get saved email
  Future<String?> getSavedEmail() async {
    return await _storage.read(key: StorageKeys.savedEmail);
  }

  /// Clear user data
  Future<void> clearUserData() async {
    await _storage.delete(key: StorageKeys.userId);
    await _storage.delete(key: StorageKeys.userData);
  }

  /// Clear all data (logout)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
