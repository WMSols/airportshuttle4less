import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/data/models/auth/login_request.dart';
import 'package:airportshuttle4less/data/models/auth/register_request.dart';

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

  /// Register new user. Returns raw response (Map or String) for repository to normalize.
  Future<dynamic> register(RegisterRequest request) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: request.toJson(),
    );
    return response.data;
  }

  /// Forgot password - POST MailPassword, returns { "retCode": 1 } on success
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await _dio.post(
      ApiConstants.forgotPassword,
      data: {'Email': email},
    );
    return response.data as Map<String, dynamic>;
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
