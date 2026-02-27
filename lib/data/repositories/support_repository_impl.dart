import '../../domain/repositories/support_repository.dart';
import '../data_sources/remote/support_api.dart';

/// Support repository implementation
/// Only includes documented API endpoints
class SupportRepositoryImpl implements SupportRepository {
  final SupportApi _api;

  SupportRepositoryImpl({required SupportApi api}) : _api = api;

  @override
  Future<void> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    String? bookingReference,
  }) async {
    await _api.saveComment(
      name: name,
      message: comment,
    );
  }

  @override
  Future<void> requestQuote({
    required String companyName,
    required String contactName,
    required String email,
    required String phone,
    required String serviceType,
    required String pickupLocation,
    required String dropoffLocation,
    required int passengerCount,
    required String frequency,
    String? message,
  }) async {
    // Not documented
  }

  @override
  Future<void> contactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    // Not documented
  }

  @override
  Future<List<FaqItem>> getFaqs() async {
    return [];
  }

  @override
  Future<List<FaqItem>> getFaqsByCategory(String category) async {
    return [];
  }

  @override
  Future<ContactInfo> getContactInfo() async {
    return ContactInfo(
      phone: '',
      email: '',
    );
  }

  @override
  Future<SupportTicket> createTicket({
    required String subject,
    required String description,
    required String category,
  }) async {
    throw Exception('Ticket endpoint not documented');
  }

  @override
  Future<List<SupportTicket>> getTickets() async {
    return [];
  }

  @override
  Future<SupportTicket> getTicketById(String id) async {
    throw Exception('Ticket endpoint not documented');
  }

  @override
  Future<SupportMessage> addMessage({
    required String ticketId,
    required String message,
    String? attachmentPath,
  }) async {
    throw Exception('Ticket message endpoint not documented');
  }

  @override
  Future<void> closeTicket(String ticketId) async {
    // Not documented
  }
}
