import '../../domain/repositories/payment_repository.dart';
import '../data_sources/remote/payment_api.dart';

/// Payment repository implementation
/// No payment endpoints are documented in the API documentation
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApi _api;

  PaymentRepositoryImpl({required PaymentApi api}) : _api = api;

  @override
  Future<PaymentResult> processPayment({
    required String bookingId,
    required double amount,
    required PaymentMethod paymentMethod,
  }) async {
    // Not documented - return failure
    return PaymentResult(
      success: false,
      message: 'Payment endpoint not documented',
    );
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<PaymentMethod> addPaymentMethod({
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String cvv,
    required String cardHolderName,
    bool setAsDefault = false,
  }) async {
    // Not documented - throw exception
    throw Exception('Payment method endpoint not documented');
  }

  @override
  Future<void> deletePaymentMethod(String id) async {
    // Not documented - no-op
  }

  @override
  Future<void> setDefaultPaymentMethod(String id) async {
    // Not documented - no-op
  }

  @override
  Future<List<PaymentHistoryItem>> getPaymentHistory() async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<PaymentResult> requestRefund({
    required String bookingId,
    required String reason,
  }) async {
    // Not documented - return failure
    return PaymentResult(
      success: false,
      message: 'Refund endpoint not documented',
    );
  }

  @override
  Future<PaymentDetails> getPaymentDetails(String bookingId) async {
    // Not documented - throw exception
    throw Exception('Payment details endpoint not documented');
  }
}
