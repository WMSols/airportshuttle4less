import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/booking/booking_request.dart';
import '../../models/booking/booking_response.dart';

/// Booking API for reservation endpoints
class BookingApi {
  final Dio _dio;

  BookingApi(this._dio);

  /// Create new booking
  Future<BookingResponse> createBooking(BookingRequest request) async {
    final response = await _dio.post(
      ApiConstants.addReservation,
      data: request.toJson(),
    );
    return BookingResponse.fromJson(response.data);
  }

  /// Apply promo code
  Future<Map<String, dynamic>> applyPromoCode(String code) async {
    final response = await _dio.post(
      ApiConstants.applyOffer,
      data: {'Code': code},
    );
    return response.data;
  }

  /// Check if email exists
  Future<Map<String, dynamic>> checkEmail(String email) async {
    final response = await _dio.post(
      ApiConstants.checkEmail,
      data: {'Email': email},
    );
    return response.data;
  }

  /// Add corporate reservation
  Future<BookingResponse> addCorporateReservation(BookingRequest request) async {
    final response = await _dio.post(
      ApiConstants.addCorporateReservation,
      data: {
        ...request.toJson(),
        'IsCorp': true,
      },
    );
    return BookingResponse.fromJson(response.data);
  }
}
