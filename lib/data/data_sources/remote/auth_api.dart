import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/register_request.dart';

/// Auth API for authentication endpoints
class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  /// Login with email and password
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: request.toJson(),
    );
    return response.data as Map<String, dynamic>;
  }

  /// Register new user
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    return response.data as Map<String, dynamic>;
  }

  /// Forgot password
  Future<void> forgotPassword(String email) async {
    await _dio.post(
      ApiConstants.forgotPassword,
      data: {'Email': email},
    );
  }

  /// Corporate login
  Future<Map<String, dynamic>> corporateLogin(LoginRequest request) async {
    final response = await _dio.post(
      ApiConstants.corporateLogin,
      data: request.toJson(),
    );
    return response.data as Map<String, dynamic>;
  }
}
