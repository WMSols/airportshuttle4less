import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

import 'package:airportshuttle4less/core/constants/storage_keys.dart';
import 'package:airportshuttle4less/core/utils/auth/auth_role.dart';

/// Secure storage wrapper for local data persistence
class SecureStorageSource {
  final FlutterSecureStorage _storage;
  bool _didAttemptRecovery = false;

  SecureStorageSource({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

  /// Save user ID
  Future<void> saveUserId(String userId) async {
    await _safeRun(
      () => _storage.write(key: StorageKeys.userId, value: userId),
    );
  }

  /// Get user ID
  Future<String?> getUserId() async {
    return _safeRun(() => _storage.read(key: StorageKeys.userId));
  }

  /// Save user data as JSON string
  Future<void> saveUserData(String userJson) async {
    await _safeRun(
      () => _storage.write(key: StorageKeys.userData, value: userJson),
    );
  }

  /// Get user data
  Future<String?> getUserData() async {
    return _safeRun(() => _storage.read(key: StorageKeys.userData));
  }

  /// Save remember me preference
  Future<void> saveRememberMe(
    bool value, {
    AuthRole role = AuthRole.standardUser,
  }) async {
    final rememberKey = role == AuthRole.corporate
        ? StorageKeys.rememberMeCorporate
        : StorageKeys.rememberMe;
    await _safeRun(
      () => _storage.write(key: rememberKey, value: value.toString()),
    );
  }

  /// Get remember me preference
  Future<bool> getRememberMe({AuthRole role = AuthRole.standardUser}) async {
    final rememberKey = role == AuthRole.corporate
        ? StorageKeys.rememberMeCorporate
        : StorageKeys.rememberMe;
    final value = await _safeRun(() => _storage.read(key: rememberKey));
    return value == 'true';
  }

  /// Save onboarding completed status
  Future<void> saveOnboardingCompleted(bool value) async {
    await _safeRun(
      () => _storage.write(
        key: StorageKeys.onboardingCompleted,
        value: value.toString(),
      ),
    );
  }

  /// Get onboarding completed status
  Future<bool> isOnboardingCompleted() async {
    final value = await _safeRun(
      () => _storage.read(key: StorageKeys.onboardingCompleted),
    );
    return value == 'true';
  }

  /// Save email for remember me
  Future<void> saveSavedEmail(
    String email, {
    AuthRole role = AuthRole.standardUser,
  }) async {
    final emailKey = role == AuthRole.corporate
        ? StorageKeys.rememberedEmailCorporate
        : StorageKeys.savedEmail;
    await _safeRun(() => _storage.write(key: emailKey, value: email));
  }

  /// Get saved email
  Future<String?> getSavedEmail({AuthRole role = AuthRole.standardUser}) async {
    final emailKey = role == AuthRole.corporate
        ? StorageKeys.rememberedEmailCorporate
        : StorageKeys.savedEmail;
    return _safeRun(() => _storage.read(key: emailKey));
  }

  /// Save password for remember me (pre-fill only; use secure storage)
  Future<void> saveSavedPassword(
    String password, {
    AuthRole role = AuthRole.standardUser,
  }) async {
    final passwordKey = role == AuthRole.corporate
        ? StorageKeys.rememberedPasswordCorporate
        : StorageKeys.rememberedPassword;
    await _safeRun(() => _storage.write(key: passwordKey, value: password));
  }

  /// Get saved password for remember me
  Future<String?> getSavedPassword({
    AuthRole role = AuthRole.standardUser,
  }) async {
    final passwordKey = role == AuthRole.corporate
        ? StorageKeys.rememberedPasswordCorporate
        : StorageKeys.rememberedPassword;
    return _safeRun(() => _storage.read(key: passwordKey));
  }

  /// Clear remembered credentials (email/password)
  Future<void> clearRememberedCredentials({
    AuthRole role = AuthRole.standardUser,
  }) async {
    final emailKey = role == AuthRole.corporate
        ? StorageKeys.rememberedEmailCorporate
        : StorageKeys.savedEmail;
    final passwordKey = role == AuthRole.corporate
        ? StorageKeys.rememberedPasswordCorporate
        : StorageKeys.rememberedPassword;
    await _safeRun(() => _storage.delete(key: emailKey));
    await _safeRun(() => _storage.delete(key: passwordKey));
  }

  /// Clear user data
  Future<void> clearUserData() async {
    await _safeRun(() => _storage.delete(key: StorageKeys.userId));
    await _safeRun(() => _storage.delete(key: StorageKeys.userData));
  }

  /// Clear all data (logout)
  Future<void> clearAll() async {
    await _safeRun(() => _storage.deleteAll(), recoverOnError: false);
  }

  Future<T?> _safeRun<T>(
    Future<T?> Function() action, {
    bool recoverOnError = true,
  }) async {
    try {
      return await action();
    } on PlatformException {
      if (recoverOnError) {
        await _recoverStorageIfNeeded();
      }
      return null;
    } catch (_) {
      if (recoverOnError) {
        await _recoverStorageIfNeeded();
      }
      return null;
    }
  }

  Future<void> _recoverStorageIfNeeded() async {
    if (_didAttemptRecovery) return;
    _didAttemptRecovery = true;
    try {
      await _storage.deleteAll();
    } catch (_) {
      // Ignore recovery errors. Callers still receive safe fallback values.
    }
  }
}
