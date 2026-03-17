import 'package:airportshuttle4less/domain/entities/comment.dart';

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
  /// Load all comments (reviews). Returns list from LoadAllComment Arr.
  Future<List<Comment>> loadAllComments();

  /// Save a comment/feedback. Date format yyyy-MM-dd.
  Future<bool> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    required String date,
    String? bookingReference,
  });

  /// Delete a comment by Sid.
  Future<bool> deleteComment(int sid);

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

  /// EnquiryMail – contact form (Name, MobileNo, Email, Message). Returns true if retCode == 1.
  Future<bool> sendEnquiry({
    required String name,
    required String mobileNo,
    required String email,
    required String message,
  });

  /// QuoteMail – personalized quote request. Returns true if retCode == 1.
  Future<bool> sendQuoteMail({
    required String firstName,
    required String lastName,
    required String pickUpDate,
    required String pickUpTime,
    required String pickUpLocation,
    required String destination,
    required String serviceType,
    required String vehicleType,
    required String hours,
    required String passengers,
    required String phone,
    required String email,
    required String message,
    required String currentPageUrl,
    String ccEmails = '',
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
