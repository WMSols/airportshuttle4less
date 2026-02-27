/// Booking request model for API
class BookingRequest {
  final String pickupLocationId;
  final String dropoffLocationId;
  final String pickupAddress;
  final String dropoffAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final String pickupDateTime;
  final String vehicleId;
  final int passengerCount;
  final String passengerName;
  final String passengerPhone;
  final String? passengerEmail;
  final double subtotal;
  final double discount;
  final double tax;
  final double totalAmount;
  final String? promoCode;
  final String? notes;
  final bool isCorporate;
  final String? corporateName;

  const BookingRequest({
    required this.pickupLocationId,
    required this.dropoffLocationId,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.pickupDateTime,
    required this.vehicleId,
    required this.passengerCount,
    required this.passengerName,
    required this.passengerPhone,
    this.passengerEmail,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.totalAmount,
    this.promoCode,
    this.notes,
    this.isCorporate = false,
    this.corporateName,
  });

  Map<String, dynamic> toJson() {
    return {
      'pickup_location_id': pickupLocationId,
      'dropoff_location_id': dropoffLocationId,
      'pickup_address': pickupAddress,
      'dropoff_address': dropoffAddress,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'pickup_date_time': pickupDateTime,
      'vehicle_id': vehicleId,
      'passenger_count': passengerCount,
      'passenger_name': passengerName,
      'passenger_phone': passengerPhone,
      'passenger_email': passengerEmail,
      'subtotal': subtotal,
      'discount': discount,
      'tax': tax,
      'total_amount': totalAmount,
      'promo_code': promoCode,
      'notes': notes,
      'is_corporate': isCorporate,
      'corporate_name': corporateName,
    };
  }
}
