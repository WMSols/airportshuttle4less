import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';

/// Support API for support-related endpoints
class SupportApi {
  final Dio _dio;

  SupportApi(this._dio);

  /// Save comment/feedback
  Future<void> saveComment({
    required String name,
    required String message,
  }) async {
    await _dio.post(
      ApiConstants.saveComment,
      data: {
        'Name': name,
        'Message': message,
      },
    );
  }

  /// Quote Mail
  Future<void> quoteMail({
    required String firstName,
    required String destination,
  }) async {
    await _dio.post(
      ApiConstants.quoteMail,
      data: {
        'first_name': firstName,
        'destination': destination,
      },
    );
  }
}
