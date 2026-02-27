import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/errors/failures.dart';
import 'package:airportshuttle4less/core/network/api_result.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

/// Maps DioException and response to [ApiFailure] / [Failure].
class ApiExceptions {
  ApiExceptions._();

  static ApiFailure<T> handle<T>(dynamic error, StackTrace stackTrace) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode;
      final data = response?.data;

      // Connection/network errors (no or failed connection)
      switch (error.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiFailure<T>(
            message: AppTexts.noInternetConnection,
            isConnectionError: true,
          );
        default:
          break;
      }

      if (statusCode == 401) {
        return ApiFailure<T>(message: AppTexts.sessionExpired, statusCode: 401);
      }

      if (statusCode == 422 && data is Map<String, dynamic>) {
        final detail = data['detail'];
        Map<String, String>? fieldErrors;
        if (detail is List) {
          fieldErrors = {};
          for (final e in detail) {
            if (e is Map<String, dynamic>) {
              final loc = e['loc'] as List?;
              final msg = e['msg'] as String?;
              if (loc != null && loc.isNotEmpty && msg != null) {
                final key = loc.length > 1
                    ? loc.sublist(1).join('.')
                    : loc.first.toString();
                fieldErrors[key] = msg;
              }
            }
          }
        }
        return ApiFailure<T>(
          message: AppTexts.validationFailed,
          statusCode: 422,
          fieldErrors: fieldErrors,
        );
      }

      final message =
          _getMessage(data) ??
          error.message?.toString() ??
          AppTexts.requestFailedTryAgain;
      return ApiFailure<T>(message: message, statusCode: statusCode);
    }

    return ApiFailure<T>(
      message: error.toString().isNotEmpty
          ? error.toString()
          : AppTexts.somethingWentWrongTryAgain,
    );
  }

  static String? _getMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['detail'] as String? ?? data['message'] as String?;
    }
    if (data is String) return data;
    return null;
  }

  static Failure toFailure<T>(ApiFailure<T> f) {
    if (f.isConnectionError) {
      return NetworkFailure(message: f.message);
    }
    if (f.statusCode == 401) {
      return UnauthorizedFailure(message: f.message);
    }
    if (f.statusCode == 422) {
      return ValidationFailure(message: f.message, fieldErrors: f.fieldErrors);
    }
    return ServerFailure(message: f.message, statusCode: f.statusCode);
  }
}
