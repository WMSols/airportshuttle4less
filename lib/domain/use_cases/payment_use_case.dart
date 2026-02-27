import '../repositories/payment_repository.dart';

/// Payment use case for payment operations
class PaymentUseCase {
  final PaymentRepository _repository;

  PaymentUseCase(this._repository);

  /// Process payment for booking
  Future<PaymentResult> processPayment({
    required String bookingId,
    required double amount,
    required PaymentMethod paymentMethod,
  }) {
    return _repository.processPayment(
      bookingId: bookingId,
      amount: amount,
      paymentMethod: paymentMethod,
    );
  }

  /// Get saved payment methods
  Future<List<PaymentMethod>> getPaymentMethods() {
    return _repository.getPaymentMethods();
  }

  /// Add new payment method
  Future<PaymentMethod> addPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
    bool setAsDefault = false,
  }) {
    return _repository.addPaymentMethod(
      cardNumber: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvv: cvv,
      cardHolderName: cardHolderName,
      setAsDefault: setAsDefault,
    );
  }

  /// Delete payment method
  Future<void> deletePaymentMethod(String id) {
    return _repository.deletePaymentMethod(id);
  }

  /// Set default payment method
  Future<void> setDefaultPaymentMethod(String id) {
    return _repository.setDefaultPaymentMethod(id);
  }

  /// Get payment history
  Future<List<PaymentHistoryItem>> getPaymentHistory() {
    return _repository.getPaymentHistory();
  }

  /// Request refund
  Future<PaymentResult> requestRefund({
    required String bookingId,
    required String reason,
  }) {
    return _repository.requestRefund(
      bookingId: bookingId,
      reason: reason,
    );
  }

  /// Get payment details for booking
  Future<PaymentDetails> getPaymentDetails(String bookingId) {
    return _repository.getPaymentDetails(bookingId);
  }
}
