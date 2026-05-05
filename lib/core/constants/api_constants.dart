import 'package:airportshuttle4less/core/config/env_config.dart';

/// API values loaded from .env only.
class ApiConstants {
  ApiConstants._();

  static String get baseUrl => EnvConfig.baseUrl;

  static const int connectTimeoutMs = 100000;
  static const int receiveTimeoutMs = 100000;

  // Auth endpoints
  static String get login => EnvConfig.apiLogin;
  static String get register => EnvConfig.apiRegister;
  static String get forgotPassword => EnvConfig.apiForgotPassword;
  static String get corporateLogin => EnvConfig.apiCorporateLogin;

  // Booking endpoints
  static String get addReservation => EnvConfig.apiAddReservation;
  static String get applyOffer => EnvConfig.apiApplyOffer;
  static String get checkEmail => EnvConfig.apiCheckEmail;

  // SearchHandler endpoints (vehicles for reservation)
  static String get loadVehicles => EnvConfig.apiLoadVehicles;

  // Admin endpoints
  static String get getAllCustomers => EnvConfig.apiGetAllCustomers;
  static String get addCustomer => EnvConfig.apiAddCustomer;
  static String get loadDistanceRate => EnvConfig.apiLoadDistanceRate;
  static String get loadHourlyRate => EnvConfig.apiLoadHourlyRate;
  static String get getA4slAirports => EnvConfig.apiGetA4slAirports;
  static String get getAllOffer => EnvConfig.apiGetAllOffer;

  // Corporate endpoints
  static String get addCorporateReservation =>
      EnvConfig.apiAddCorporateReservation;

  // Support/Misc endpoints
  static String get loadAllComment => EnvConfig.apiLoadAllComment;
  static String get saveComment => EnvConfig.apiSaveComment;
  static String get deleteComment => EnvConfig.apiDeleteComment;
  static String get enquiryMail => EnvConfig.apiEnquiryMail;
  static String get quoteMail => EnvConfig.apiQuoteMail;
}
