/// Support ticket entity
class SupportTicket {
  final String id;
  final String subject;
  final String description;
  final String category;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<SupportMessage> messages;

  const SupportTicket({
    required this.id,
    required this.subject,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.messages = const [],
  });

  bool get isOpen => status.toLowerCase() == 'open';
  bool get isPending => status.toLowerCase() == 'pending';
  bool get isClosed => status.toLowerCase() == 'closed';
}

/// Support message entity
class SupportMessage {
  final String id;
  final String ticketId;
  final String message;
  final bool isFromSupport;
  final DateTime createdAt;
  final String? attachmentUrl;

  const SupportMessage({
    required this.id,
    required this.ticketId,
    required this.message,
    required this.isFromSupport,
    required this.createdAt,
    this.attachmentUrl,
  });
}

/// FAQ item
class FaqItem {
  final String id;
  final String question;
  final String answer;
  final String category;

  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
  });
}

/// Contact info
class ContactInfo {
  final String phone;
  final String email;
  final String? whatsapp;
  final String? address;
  final String? workingHours;

  const ContactInfo({
    required this.phone,
    required this.email,
    this.whatsapp,
    this.address,
    this.workingHours,
  });
}

/// Support repository interface defining support operations
abstract class SupportRepository {
  /// Save a comment/feedback
  Future<void> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    String? bookingReference,
  });

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
  });

  /// Contact us / send inquiry email
  Future<void> contactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  });

  /// Get FAQ items
  Future<List<FaqItem>> getFaqs();

  /// Get FAQ by category
  Future<List<FaqItem>> getFaqsByCategory(String category);

  /// Get contact information
  Future<ContactInfo> getContactInfo();

  /// Create support ticket
  Future<SupportTicket> createTicket({
    required String subject,
    required String description,
    required String category,
  });

  /// Get user's support tickets
  Future<List<SupportTicket>> getTickets();

  /// Get ticket by ID
  Future<SupportTicket> getTicketById(String id);

  /// Add message to ticket
  Future<SupportMessage> addMessage({
    required String ticketId,
    required String message,
    String? attachmentPath,
  });

  /// Close ticket
  Future<void> closeTicket(String ticketId);
}
