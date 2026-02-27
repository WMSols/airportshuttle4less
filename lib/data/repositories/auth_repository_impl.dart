import 'dart:convert';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/auth_token_holder.dart';
import '../data_sources/local/secure_storage_source.dart';
import '../data_sources/remote/auth_api.dart';
import '../models/auth/login_request.dart';
import '../models/auth/register_request.dart';
import '../models/auth/user_model.dart';

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
  })  : _api = api,
        _secureStorage = secureStorage,
        _tokenHolder = tokenHolder;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.login(LoginRequest(
      email: email,
      password: password,
    ));

    final loginDetails = response['LoginDetails'];
    if (loginDetails != null && loginDetails is Map<String, dynamic>) {
      final user = UserModel.fromJson(loginDetails).toEntity();
      await _secureStorage.saveUserId(user.id);
      await _secureStorage.saveUserData(jsonEncode(loginDetails));
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
    
    final response = await _api.register(RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    ));

    final retCode = response['retCode'];
    if (retCode == 1) {
      return User(
        id: '',
        name: name,
        email: email,
        phone: phone,
        role: 'user',
      );
    }
    
    throw Exception('Registration failed');
  }

  @override
  Future<void> logout() async {
    _tokenHolder.clearTokens();
    await _secureStorage.clearUserData();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userData = await _secureStorage.getUserData();
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData)).toEntity();
    }
    return null;
  }

  @override
  Future<bool> isLoggedIn() async {
    return _tokenHolder.isTokenValid;
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _secureStorage.saveRememberMe(value);
  }

  @override
  Future<bool> getRememberMe() async {
    return await _secureStorage.getRememberMe();
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
    await _api.forgotPassword(email);
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
    final currentUser = await getCurrentUser();
    if (currentUser != null) {
      return currentUser;
    }
    throw Exception('No user logged in');
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
