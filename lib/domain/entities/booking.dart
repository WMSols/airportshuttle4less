import 'location.dart';
import 'vehicle.dart';
import 'user.dart';

/// Booking status enum
enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

/// Payment status enum
enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

/// Booking entity representing a reservation
class Booking {
  final String id;
  final String referenceNumber;
  final User? user;
  final Location pickupLocation;
  final Location dropoffLocation;
  final DateTime pickupDateTime;
  final Vehicle vehicle;
  final int passengerCount;
  final String? passengerName;
  final String? passengerPhone;
  final String? passengerEmail;
  final double subtotal;
  final double discount;
  final double tax;
  final double totalAmount;
  final String? promoCode;
  final BookingStatus status;
  final PaymentStatus paymentStatus;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isCorporate;
  final String? corporateName;

  const Booking({
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
    this.discount = 0,
    required this.tax,
    required this.totalAmount,
    this.promoCode,
    this.status = BookingStatus.pending,
    this.paymentStatus = PaymentStatus.pending,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.isCorporate = false,
    this.corporateName,
  });

  bool get isPending => status == BookingStatus.pending;
  bool get isConfirmed => status == BookingStatus.confirmed;
  bool get isInProgress => status == BookingStatus.inProgress;
  bool get isCompleted => status == BookingStatus.completed;
  bool get isCancelled => status == BookingStatus.cancelled;

  bool get isPaid => paymentStatus == PaymentStatus.paid;
  bool get paymentPending => paymentStatus == PaymentStatus.pending;

  bool get canCancel =>
      status == BookingStatus.pending || status == BookingStatus.confirmed;

  bool get canModify =>
      status == BookingStatus.pending && DateTime.now().isBefore(pickupDateTime);

  String get statusDisplayName {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get paymentStatusDisplayName {
    switch (paymentStatus) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  Booking copyWith({
    String? id,
    String? referenceNumber,
    User? user,
    Location? pickupLocation,
    Location? dropoffLocation,
    DateTime? pickupDateTime,
    Vehicle? vehicle,
    int? passengerCount,
    String? passengerName,
    String? passengerPhone,
    String? passengerEmail,
    double? subtotal,
    double? discount,
    double? tax,
    double? totalAmount,
    String? promoCode,
    BookingStatus? status,
    PaymentStatus? paymentStatus,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCorporate,
    String? corporateName,
  }) {
    return Booking(
      id: id ?? this.id,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      user: user ?? this.user,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      pickupDateTime: pickupDateTime ?? this.pickupDateTime,
      vehicle: vehicle ?? this.vehicle,
      passengerCount: passengerCount ?? this.passengerCount,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
      passengerEmail: passengerEmail ?? this.passengerEmail,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      totalAmount: totalAmount ?? this.totalAmount,
      promoCode: promoCode ?? this.promoCode,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCorporate: isCorporate ?? this.isCorporate,
      corporateName: corporateName ?? this.corporateName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Booking && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
