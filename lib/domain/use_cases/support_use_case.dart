import 'package:airportshuttle4less/domain/entities/comment.dart';
import 'package:airportshuttle4less/domain/repositories/support_repository.dart';

/// Support use case for support operations
class SupportUseCase {
  final SupportRepository _repository;

  SupportUseCase(this._repository);

  /// Load all comments (reviews).
  Future<List<Comment>> loadAllComments() {
    return _repository.loadAllComments();
  }

  /// Save a comment/feedback. Date in yyyy-MM-dd.
  Future<bool> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    required String date,
    String? bookingReference,
  }) {
    return _repository.saveComment(
      name: name,
      email: email,
      phone: phone,
      comment: comment,
      date: date,
      bookingReference: bookingReference,
    );
  }

  /// Delete a comment by id.
  Future<bool> deleteComment(int sid) {
    return _repository.deleteComment(sid);
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

  /// EnquiryMail – contact form. Returns true if retCode == 1.
  Future<bool> sendEnquiry({
    required String name,
    required String mobileNo,
    required String email,
    required String message,
  }) {
    return _repository.sendEnquiry(
      name: name,
      mobileNo: mobileNo,
      email: email,
      message: message,
    );
  }

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
  }) {
    return _repository.sendQuoteMail(
      firstName: firstName,
      lastName: lastName,
      pickUpDate: pickUpDate,
      pickUpTime: pickUpTime,
      pickUpLocation: pickUpLocation,
      destination: destination,
      serviceType: serviceType,
      vehicleType: vehicleType,
      hours: hours,
      passengers: passengers,
      phone: phone,
      email: email,
      message: message,
      currentPageUrl: currentPageUrl,
      ccEmails: ccEmails,
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
