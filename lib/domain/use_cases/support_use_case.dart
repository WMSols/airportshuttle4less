import '../repositories/support_repository.dart';

/// Support use case for support operations
class SupportUseCase {
  final SupportRepository _repository;

  SupportUseCase(this._repository);

  /// Save a comment/feedback
  Future<void> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    String? bookingReference,
  }) {
    return _repository.saveComment(
      name: name,
      email: email,
      phone: phone,
      comment: comment,
      bookingReference: bookingReference,
    );
  }

  /// Request a quote for corporate booking
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
  }) {
    return _repository.requestQuote(
      companyName: companyName,
      contactName: contactName,
      email: email,
      phone: phone,
      serviceType: serviceType,
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      passengerCount: passengerCount,
      frequency: frequency,
      message: message,
    );
  }

  /// Send contact email
  Future<void> contactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    return _repository.contactEmail(
      name: name,
      email: email,
      subject: subject,
      message: message,
    );
  }

  /// Get FAQ items
  Future<List<FaqItem>> getFaqs() {
    return _repository.getFaqs();
  }

  /// Get FAQs by category
  Future<List<FaqItem>> getFaqsByCategory(String category) {
    return _repository.getFaqsByCategory(category);
  }

  /// Get contact information
  Future<ContactInfo> getContactInfo() {
    return _repository.getContactInfo();
  }

  /// Create support ticket
  Future<SupportTicket> createTicket({
    required String subject,
    required String description,
    required String category,
  }) {
    return _repository.createTicket(
      subject: subject,
      description: description,
      category: category,
    );
  }

  /// Get user's tickets
  Future<List<SupportTicket>> getTickets() {
    return _repository.getTickets();
  }

  /// Get ticket by ID
  Future<SupportTicket> getTicketById(String id) {
    return _repository.getTicketById(id);
  }

  /// Add message to ticket
  Future<SupportMessage> addMessage({
    required String ticketId,
    required String message,
    String? attachmentPath,
  }) {
    return _repository.addMessage(
      ticketId: ticketId,
      message: message,
      attachmentPath: attachmentPath,
    );
  }

  /// Close ticket
  Future<void> closeTicket(String ticketId) {
    return _repository.closeTicket(ticketId);
  }
}
