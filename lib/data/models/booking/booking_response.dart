import '../../../domain/entities/booking.dart';
import '../../../domain/entities/location.dart';
import '../auth/user_model.dart';
import '../vehicle/vehicle_model.dart';

/// Booking response model from API
class BookingResponse {
  final String id;
  final String referenceNumber;
  final UserModel? user;
  final LocationModel pickupLocation;
  final LocationModel dropoffLocation;
  final String pickupDateTime;
  final VehicleModel vehicle;
  final int passengerCount;
  final String? passengerName;
  final String? passengerPhone;
  final String? passengerEmail;
  final double subtotal;
  final double discount;
  final double tax;
  final double totalAmount;
  final String? promoCode;
  final String status;
  final String paymentStatus;
  final String? notes;
  final String createdAt;
  final String? updatedAt;
  final bool isCorporate;
  final String? corporateName;

  const BookingResponse({
    required this.id,
    required this.referenceNumber,
    this.user,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDateTime,
    required this.vehicle,
    required this.passengerCount,
    this.passengerName,
    this.passengerPhone,
    this.passengerEmail,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.totalAmount,
    this.promoCode,
    required this.status,
    required this.paymentStatus,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.isCorporate = false,
    this.corporateName,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id']?.toString() ?? '',
      referenceNumber: json['reference_number'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      pickupLocation: LocationModel.fromJson(json['pickup_location'] ?? {}),
      dropoffLocation: LocationModel.fromJson(json['dropoff_location'] ?? {}),
      pickupDateTime: json['pickup_date_time'] ?? '',
      vehicle: VehicleModel.fromJson(json['vehicle'] ?? {}),
      passengerCount: json['passenger_count'] ?? 1,
      passengerName: json['passenger_name'],
      passengerPhone: json['passenger_phone'],
      passengerEmail: json['passenger_email'],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      promoCode: json['promo_code'],
      status: json['status'] ?? 'pending',
      paymentStatus: json['payment_status'] ?? 'pending',
      notes: json['notes'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'],
      isCorporate: json['is_corporate'] ?? false,
      corporateName: json['corporate_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_number': referenceNumber,
      'user': user?.toJson(),
      'pickup_location': pickupLocation.toJson(),
      'dropoff_location': dropoffLocation.toJson(),
      'pickup_date_time': pickupDateTime,
      'vehicle': vehicle.toJson(),
      'passenger_count': passengerCount,
      'passenger_name': passengerName,
      'passenger_phone': passengerPhone,
      'passenger_email': passengerEmail,
      'subtotal': subtotal,
      'discount': discount,
      'tax': tax,
      'total_amount': totalAmount,
      'promo_code': promoCode,
      'status': status,
      'payment_status': paymentStatus,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_corporate': isCorporate,
      'corporate_name': corporateName,
    };
  }

  BookingStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'in_progress':
        return BookingStatus.inProgress;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  PaymentStatus _parsePaymentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'paid':
        return PaymentStatus.paid;
      case 'failed':
        return PaymentStatus.failed;
      case 'refunded':
        return PaymentStatus.refunded;
      default:
        return PaymentStatus.pending;
    }
  }

  Booking toEntity() {
    return Booking(
      id: id,
      referenceNumber: referenceNumber,
      user: user?.toEntity(),
      pickupLocation: pickupLocation.toEntity(),
      dropoffLocation: dropoffLocation.toEntity(),
      pickupDateTime: DateTime.tryParse(pickupDateTime) ?? DateTime.now(),
      vehicle: vehicle.toEntity(),
      passengerCount: passengerCount,
      passengerName: passengerName,
      passengerPhone: passengerPhone,
      passengerEmail: passengerEmail,
      subtotal: subtotal,
      discount: discount,
      tax: tax,
      totalAmount: totalAmount,
      promoCode: promoCode,
      status: _parseStatus(status),
      paymentStatus: _parsePaymentStatus(paymentStatus),
      notes: notes,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      updatedAt:
          updatedAt != null ? DateTime.tryParse(updatedAt!) : null,
      isCorporate: isCorporate,
      corporateName: corporateName,
    );
  }
}

/// Location model for API
class LocationModel {
  final String id;
  final String address;
  final String? airportName;
  final String? city;
  final double latitude;
  final double longitude;
  final String? postalCode;
  final String? country;

  const LocationModel({
    required this.id,
    required this.address,
    this.airportName,
    this.city,
    required this.latitude,
    required this.longitude,
    this.postalCode,
    this.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id']?.toString() ?? '',
      address: json['address'] ?? '',
      airportName: json['airport_name'],
      city: json['city'],
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      postalCode: json['postal_code'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'airport_name': airportName,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'postal_code': postalCode,
      'country': country,
    };
  }

  Location toEntity() {
    return Location(
      id: id,
      address: address,
      airportName: airportName,
      city: city,
      latitude: latitude,
      longitude: longitude,
      postalCode: postalCode,
      country: country,
    );
  }
}
