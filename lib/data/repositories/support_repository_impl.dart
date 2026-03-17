import 'dart:convert';

import 'package:airportshuttle4less/domain/entities/comment.dart';
import 'package:airportshuttle4less/domain/repositories/support_repository.dart';
import 'package:airportshuttle4less/data/data_sources/remote/support_api.dart';

/// Support repository implementation
/// Only includes documented API endpoints
class SupportRepositoryImpl implements SupportRepository {
  final SupportApi _api;

  SupportRepositoryImpl({required SupportApi api}) : _api = api;

  /// Unwrap ASP.NET AJAX response: server may return { "d": { ... } }, { "d": "{\"retCode\":1}" }, or plain { "retCode": 1 }.
  static Map<String, dynamic> _unwrapResponse(dynamic response) {
    if (response is String) {
      try {
        return jsonDecode(response) as Map<String, dynamic>;
      } catch (_) {
        return <String, dynamic>{};
      }
    }
    if (response is! Map<String, dynamic>) {
      return <String, dynamic>{};
    }
    final d = response['d'];
    if (d == null) return response;
    if (d is Map<String, dynamic>) return d;
    if (d is String) {
      try {
        return jsonDecode(d) as Map<String, dynamic>;
      } catch (_) {
        return response;
      }
    }
    return response;
  }

  static bool _isSuccess(Map<String, dynamic> data) {
    final retCode = data['retCode'] ?? data['RetCode'];
    return retCode == 1 || retCode == '1';
  }

  @override
  Future<List<Comment>> loadAllComments() async {
    final raw = await _api.loadAllComment();
    final data = _unwrapResponse(raw);
    final arr = data['Arr'];
    if (arr is! List) return [];
    final list = <Comment>[];
    for (final e in arr) {
      if (e is Map<String, dynamic>) {
        list.add(Comment.fromJson(e));
      }
    }
    return list;
  }

  @override
  Future<bool> saveComment({
    required String name,
    required String email,
    required String phone,
    required String comment,
    required String date,
    String? bookingReference,
  }) async {
    final raw = await _api.saveComment(
      name: name,
      message: comment,
      email: email,
      phoneNo: phone,
      date: date,
    );
    final data = _unwrapResponse(raw);
    return _isSuccess(data);
  }

  @override
  Future<bool> deleteComment(int sid) async {
    final raw = await _api.deleteComment(sid: sid);
    final data = _unwrapResponse(raw);
    return _isSuccess(data);
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
  Future<bool> sendEnquiry({
    required String name,
    required String mobileNo,
    required String email,
    required String message,
  }) async {
    final raw = await _api.enquiryMail(
      name: name,
      mobileNo: mobileNo,
      email: email,
      message: message,
    );
    final data = _unwrapResponse(raw);
    return _isSuccess(data);
  }

  @override
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
  }) async {
    final raw = await _api.quoteMail(
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
    final data = _unwrapResponse(raw);
    return _isSuccess(data);
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
    return ContactInfo(phone: '', email: '');
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
