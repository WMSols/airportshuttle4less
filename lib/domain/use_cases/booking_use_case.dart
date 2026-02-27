import '../entities/booking.dart';
import '../entities/vehicle.dart';
import '../entities/location.dart';
import '../repositories/booking_repository.dart';

/// Booking use case for reservation operations
class BookingUseCase {
  final BookingRepository _repository;

  BookingUseCase(this._repository);

  /// Search available rides
  Future<List<Vehicle>> searchRides(RideSearchParams params) {
    return _repository.searchRides(params);
  }

  /// Create a new booking
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
  }) {
    return _repository.createBooking(
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      pickupDateTime: pickupDateTime,
      vehicle: vehicle,
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
  }

  /// Get all bookings
  Future<List<Booking>> getBookings() {
    return _repository.getBookings();
  }

  /// Get upcoming bookings
  Future<List<Booking>> getUpcomingBookings() {
    return _repository.getUpcomingBookings();
  }

  /// Get past bookings
  Future<List<Booking>> getPastBookings() {
    return _repository.getPastBookings();
  }

  /// Get booking by ID
  Future<Booking> getBookingById(String id) {
    return _repository.getBookingById(id);
  }

  /// Cancel a booking
  Future<Booking> cancelBooking(String id) {
    return _repository.cancelBooking(id);
  }

  /// Update a booking
  Future<Booking> updateBooking({
    required String id,
    DateTime? pickupDateTime,
    Location? pickupLocation,
    Location? dropoffLocation,
    Vehicle? vehicle,
    int? passengerCount,
    String? notes,
  }) {
    return _repository.updateBooking(
      id: id,
      pickupDateTime: pickupDateTime,
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      vehicle: vehicle,
      passengerCount: passengerCount,
      notes: notes,
    );
  }

  /// Apply promo code
  Future<PromoCodeResult> applyPromoCode(String code, double amount) {
    return _repository.applyPromoCode(code, amount);
  }

  /// Validate promo code
  Future<PromoCodeResult> validatePromoCode(String code) {
    return _repository.validatePromoCode(code);
  }

  /// Check if email exists for booking lookup
  Future<bool> checkEmailExists(String email) {
    return _repository.checkEmailExists(email);
  }

  /// Get booking by reference number and email
  Future<Booking?> getBookingByReference(String referenceNumber, String email) {
    return _repository.getBookingByReference(referenceNumber, email);
  }
}
