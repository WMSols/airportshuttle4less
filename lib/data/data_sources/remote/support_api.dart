import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';

/// Support API for support-related endpoints (EnquiryMail, QuoteMail).
class SupportApi {
  final Dio _dio;

  SupportApi(this._dio);

  /// EnquiryMail – contact form. Body: Name, MobileNo, Email, Message. Returns { "retCode": 1 } on success (may be wrapped in "d" or returned as string).
  Future<dynamic> enquiryMail({
    required String name,
    required String mobileNo,
    required String email,
    required String message,
  }) async {
    final response = await _dio.post(
      ApiConstants.enquiryMail,
      data: {
        'Name': name,
        'MobileNo': mobileNo,
        'Email': email,
        'Message': message,
      },
    );
    return response.data;
  }

  /// QuoteMail – personalized quote request. Returns { "retCode": 1 } on success (may be wrapped in "d" or returned as string).
  Future<dynamic> quoteMail({
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
    final response = await _dio.post(
      ApiConstants.quoteMail,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'pick_up_date': pickUpDate,
        'pick_up_time': pickUpTime,
        'pick_up_location': pickUpLocation,
        'destination': destination,
        'service_type': serviceType,
        'vehicle_type': vehicleType,
        'hours': hours,
        'passengers': passengers,
        'phone': phone,
        'email': email,
        'message': message,
        'current_page_url': currentPageUrl,
        'CCEmails': ccEmails,
      },
    );
    return response.data;
  }

  /// LoadAllComment – returns { "retCode": 1, "Arr": [{ "Sid", "Name", "Comment" }] }.
  Future<dynamic> loadAllComment() async {
    final response = await _dio.post(ApiConstants.loadAllComment, data: {});
    return response.data;
  }

  /// SaveComment – Body: Name, Message, Email, PhoneNo, Date (yyyy-MM-dd).
  Future<dynamic> saveComment({
    required String name,
    required String message,
    required String email,
    required String phoneNo,
    required String date,
  }) async {
    final response = await _dio.post(
      ApiConstants.saveComment,
      data: {
        'Name': name,
        'Message': message,
        'Email': email,
        'PhoneNo': phoneNo,
        'Date': date,
      },
    );
    return response.data;
  }

  /// DeleteComment – Body: { "Sid": sid }.
  Future<dynamic> deleteComment({required int sid}) async {
    final response = await _dio.post(
      ApiConstants.deleteComment,
      data: {'Sid': sid},
    );
    return response.data;
  }
}
