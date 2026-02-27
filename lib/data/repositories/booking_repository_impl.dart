import '../../domain/entities/booking.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/booking_repository.dart';
import '../data_sources/remote/booking_api.dart';
import '../models/booking/booking_request.dart';

/// Booking repository implementation
/// Only includes documented API endpoints
class BookingRepositoryImpl implements BookingRepository {
  final BookingApi _api;

  BookingRepositoryImpl({required BookingApi api}) : _api = api;

  @override
  Future<List<Vehicle>> searchRides(RideSearchParams params) async {
    return [];
  }

  @override
  Future<Booking> createBooking({
    required Location pickupLocation,
    required Location dropoffLocation,
    required DateTime pickupDateTime,
    required Vehicle vehicle,
    required int passengerCount,
    required String passengerName,
    required String passengerPhone,
    String? passengerEmail,
    required double subtotal,
    required double discount,
    required double tax,
    required double totalAmount,
    String? promoCode,
    String? notes,
    bool isCorporate = false,
    String? corporateName,
  }) async {
    final request = BookingRequest(
      pickupLocationId: pickupLocation.id,
      dropoffLocationId: dropoffLocation.id,
      pickupAddress: pickupLocation.address,
      dropoffAddress: dropoffLocation.address,
      pickupLatitude: pickupLocation.latitude,
      pickupLongitude: pickupLocation.longitude,
      dropoffLatitude: dropoffLocation.latitude,
      dropoffLongitude: dropoffLocation.longitude,
      pickupDateTime: pickupDateTime.toIso8601String(),
      vehicleId: vehicle.id,
      passengerCount: passengerCount,
      passengerName: passengerName,
      passengerPhone: passengerPhone,
      passengerEmail: passengerEmail,
      subtotal: subtotal,
      discount: discount,
      tax: tax,
      totalAmount: totalAmount,
      promoCode: promoCode,
      notes: notes,
      isCorporate: isCorporate,
      corporateName: corporateName,
    );

    final response = await _api.createBooking(request);
    return response.toEntity();
  }

  @override
  Future<List<Booking>> getBookings() async {
    return [];
  }

  @override
  Future<List<Booking>> getUpcomingBookings() async {
    return [];
  }

  @override
  Future<List<Booking>> getPastBookings() async {
    return [];
  }

  @override
  Future<Booking> getBookingById(String id) async {
    throw Exception('Get booking by ID not documented');
  }

  @override
  Future<Booking> cancelBooking(String id) async {
    throw Exception('Cancel booking not documented');
  }

  @override
  Future<Booking> updateBooking({
    required String id,
    DateTime? pickupDateTime,
    Location? pickupLocation,
    Location? dropoffLocation,
    Vehicle? vehicle,
    int? passengerCount,
    String? notes,
  }) async {
    throw Exception('Update booking not documented');
  }

  @override
  Future<PromoCodeResult> applyPromoCode(String code, double amount) async {
    final response = await _api.applyPromoCode(code);
    return PromoCodeResult(
      isValid: response['retCode'] == 1,
      code: code,
      discountAmount: response['discount_amount']?.toDouble(),
      discountPercentage: response['discount_percentage']?.toDouble(),
      message: response['message'],
    );
  }

  @override
  Future<PromoCodeResult> validatePromoCode(String code) async {
    return applyPromoCode(code, 0);
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    final response = await _api.checkEmail(email);
    return response['retCode'] == 1;
  }

  @override
  Future<Booking?> getBookingByReference(
      String referenceNumber, String email) async {
    return null;
  }
}
