import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/data/models/booking/add_reservation_request.dart';
import 'package:airportshuttle4less/data/models/booking/booking_request.dart';
import 'package:airportshuttle4less/data/models/booking/booking_response.dart';

/// Booking API for reservation endpoints
class BookingApi {
  final Dio _dio;

  BookingApi(this._dio);

  /// Add reservation (ASP.NET API: Reservation object + IsEmail).
  /// Returns map with retCode and ReservationId.
  Future<Map<String, dynamic>> addReservation(
    AddReservationRequest request, {
    bool isEmail = true,
  }) async {
    final response = await _dio.post(
      ApiConstants.addReservation,
      data: {
        'Reservation': request.toJson(),
        'IsEmail': isEmail,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  /// Create new booking (legacy request shape; prefer addReservation for new flow).
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
  Future<BookingResponse> addCorporateReservation(
    BookingRequest request,
  ) async {
    final response = await _dio.post(
      ApiConstants.addCorporateReservation,
      data: {...request.toJson(), 'IsCorp': true},
    );
    return BookingResponse.fromJson(response.data);
  }
}
