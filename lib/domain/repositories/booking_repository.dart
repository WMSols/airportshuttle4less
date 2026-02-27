import '../entities/booking.dart';
import '../entities/vehicle.dart';
import '../entities/location.dart';

/// Search parameters for finding rides
class RideSearchParams {
  final Location pickupLocation;
  final Location dropoffLocation;
  final DateTime pickupDateTime;
  final int passengerCount;
  final bool isCorporate;
  final String? corporateName;

  const RideSearchParams({
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDateTime,
    required this.passengerCount,
    this.isCorporate = false,
    this.corporateName,
  });
}

/// Promo code validation result
class PromoCodeResult {
  final bool isValid;
  final String? code;
  final double? discountAmount;
  final double? discountPercentage;
  final String? message;

  const PromoCodeResult({
    required this.isValid,
    this.code,
    this.discountAmount,
    this.discountPercentage,
    this.message,
  });
}

/// Booking repository interface defining booking operations
abstract class BookingRepository {
  /// Search available rides based on parameters
  Future<List<Vehicle>> searchRides(RideSearchParams params);

  /// Create a new booking/reservation
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
  });

  /// Get all bookings for current user
  Future<List<Booking>> getBookings();

  /// Get upcoming bookings
  Future<List<Booking>> getUpcomingBookings();

  /// Get past/completed bookings
  Future<List<Booking>> getPastBookings();

  /// Get booking by ID
  Future<Booking> getBookingById(String id);

  /// Cancel a booking
  Future<Booking> cancelBooking(String id);

  /// Update/modify a booking
  Future<Booking> updateBooking({
    required String id,
    DateTime? pickupDateTime,
    Location? pickupLocation,
    Location? dropoffLocation,
    Vehicle? vehicle,
    int? passengerCount,
    String? notes,
  });

  /// Apply promo code to booking
  Future<PromoCodeResult> applyPromoCode(String code, double amount);

  /// Validate promo code
  Future<PromoCodeResult> validatePromoCode(String code);

  /// Check if email exists for booking lookup
  Future<bool> checkEmailExists(String email);

  /// Get booking by reference number and email
  Future<Booking?> getBookingByReference(String referenceNumber, String email);
}
