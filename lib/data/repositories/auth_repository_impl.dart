import 'dart:convert';

import 'package:airportshuttle4less/domain/entities/user.dart';
import 'package:airportshuttle4less/domain/repositories/auth_repository.dart';
import 'package:airportshuttle4less/data/data_sources/local/auth_token_holder.dart';
import 'package:airportshuttle4less/data/data_sources/local/secure_storage_source.dart';
import 'package:airportshuttle4less/data/data_sources/remote/auth_api.dart';
import 'package:airportshuttle4less/data/models/auth/login_request.dart';
import 'package:airportshuttle4less/data/models/auth/register_request.dart';
import 'package:airportshuttle4less/data/models/auth/user_model.dart';

/// Auth repository implementation
/// Only includes methods for documented API endpoints
class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;
  final SecureStorageSource _secureStorage;
  final AuthTokenHolder _tokenHolder;

  AuthRepositoryImpl({
    required AuthApi api,
    required SecureStorageSource secureStorage,
    required AuthTokenHolder tokenHolder,
  }) : _api = api,
       _secureStorage = secureStorage,
       _tokenHolder = tokenHolder;

  /// Unwrap ASP.NET AJAX response: server may return { "d": { ... } } or { "d": "{\"retCode\":1}" }.
  static Map<String, dynamic> _unwrapResponse(dynamic response) {
    if (response is String) {
      return jsonDecode(response) as Map<String, dynamic>;
    }
    if (response is! Map<String, dynamic>) {
      return <String, dynamic>{};
    }
    final d = response['d'];
    if (d == null) return response;
    if (d is Map<String, dynamic>) return d;
    if (d is String) {
      return jsonDecode(d) as Map<String, dynamic>;
    }
    return response;
  }

  @override
  Future<User> login({required String email, required String password}) async {
    final response = await _api.login(
      LoginRequest(email: email, password: password),
    );
    final data = _unwrapResponse(response);

    final loginDetails = data['LoginDetails'];
    if (loginDetails != null && loginDetails is Map<String, dynamic>) {
      final user = UserModel.fromJson(loginDetails).toEntity();
      await _secureStorage.saveUserId(user.id);
      await _secureStorage.saveUserData(jsonEncode(loginDetails));
      // API doc does not list token fields; if your backend returns tokens in LoginDetails,
      // parse them here and call _tokenHolder.setTokens(...).
      return user;
    }

    throw Exception('Invalid login response');
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    bool isCorporate = false,
    String? corporateName,
  }) async {
    final nameParts = name.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    final raw = await _api.register(
      RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );
    final data = _unwrapResponse(raw);

    final retCode = data['retCode'] ?? data['RetCode'];
    if (retCode == 1 || retCode == '1') {
      return User(id: '', name: name, email: email, phone: phone, role: 'user');
    }

    throw Exception('Registration failed');
  }

  @override
  Future<void> logout() async {
    _tokenHolder.clearTokens();
    await _secureStorage.clearUserData();
    // Do not clear remembered credentials so Remember Me email/password persist
  }

  @override
  Future<User?> getCurrentUser() async {
    final userData = await _secureStorage.getUserData();
    if (userData == null || userData.isEmpty) return null;
    try {
      final map = jsonDecode(userData) as Map<String, dynamic>?;
      if (map == null || map.isEmpty) return null;
      return UserModel.fromJson(map).toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final userData = await _secureStorage.getUserData();
    return userData != null && userData.isNotEmpty;
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _secureStorage.saveRememberMe(value);
    if (!value) {
      await _secureStorage.clearRememberedCredentials();
    }
  }

  @override
  Future<bool> getRememberMe() async {
    return await _secureStorage.getRememberMe();
  }

  @override
  Future<String?> getSavedEmail() async {
    return await _secureStorage.getSavedEmail();
  }

  @override
  Future<String?> getSavedPassword() async {
    return await _secureStorage.getSavedPassword();
  }

  @override
  Future<void> saveSavedEmail(String email) async {
    await _secureStorage.saveSavedEmail(email);
  }

  @override
  Future<void> saveSavedPassword(String password) async {
    await _secureStorage.saveSavedPassword(password);
  }

  @override
  Future<void> saveOnboardingCompleted(bool value) async {
    await _secureStorage.saveOnboardingCompleted(value);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _secureStorage.isOnboardingCompleted();
  }

  @override
  Future<void> forgotPassword(String email) async {
    final response = await _api.forgotPassword(email);
    final data = _unwrapResponse(response);
    final retCode = data['retCode'] ?? data['RetCode'];
    if (retCode != 1 && retCode != '1') {
      throw Exception('Forgot password request failed');
    }
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    return false;
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    // Not documented
  }

  @override
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? profileImage,
  }) async {
    final userData = await _secureStorage.getUserData();
    if (userData == null || userData.isEmpty) {
      throw Exception('No user logged in');
    }
    final map = jsonDecode(userData) as Map<String, dynamic>;
    if (name != null) map['name'] = name;
    if (phone != null) map['phone'] = phone;
    if (profileImage != null) map['profile_image'] = profileImage;
    await _secureStorage.saveUserData(jsonEncode(map));
    return UserModel.fromJson(map).toEntity();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Not documented
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    // Not documented
    return '';
  }
}
