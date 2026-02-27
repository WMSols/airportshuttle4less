/// Payment method entity
class PaymentMethod {
  final String id;
  final String type;
  final String lastFourDigits;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cardBrand;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    this.expiryMonth,
    this.expiryYear,
    this.cardBrand,
    this.isDefault = false,
  });

  bool get isCreditCard => type.toLowerCase() == 'credit_card';
  bool get isDebitCard => type.toLowerCase() == 'debit_card';
  bool get isPayPal => type.toLowerCase() == 'paypal';
}

/// Payment result
class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? message;
  final String? errorCode;

  const PaymentResult({
    required this.success,
    this.transactionId,
    this.message,
    this.errorCode,
  });
}

/// Payment repository interface defining payment operations
abstract class PaymentRepository {
  /// Process payment for a booking
  Future<PaymentResult> processPayment({
    required String bookingId,
    required double amount,
    required PaymentMethod paymentMethod,
  });

  /// Get saved payment methods
  Future<List<PaymentMethod>> getPaymentMethods();

  /// Add new payment method
  Future<PaymentMethod> addPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
    bool setAsDefault = false,
  });

  /// Delete payment method
  Future<void> deletePaymentMethod(String id);

  /// Set default payment method
  Future<void> setDefaultPaymentMethod(String id);

  /// Get payment history
  Future<List<PaymentHistoryItem>> getPaymentHistory();

  /// Request refund
  Future<PaymentResult> requestRefund({
    required String bookingId,
    required String reason,
  });

  /// Get payment details for a booking
  Future<PaymentDetails> getPaymentDetails(String bookingId);
}

/// Payment history item
class PaymentHistoryItem {
  final String id;
  final String bookingId;
  final double amount;
  final String status;
  final DateTime date;
  final String? transactionId;

  const PaymentHistoryItem({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.status,
    required this.date,
    this.transactionId,
  });
}

/// Payment details for a booking
class PaymentDetails {
  final String bookingId;
  final double amount;
  final String status;
  final String? transactionId;
  final DateTime? paidAt;
  final String? paymentMethod;
  final String? cardLastFour;

  const PaymentDetails({
    required this.bookingId,
    required this.amount,
    required this.status,
    this.transactionId,
    this.paidAt,
    this.paymentMethod,
    this.cardLastFour,
  });
}
