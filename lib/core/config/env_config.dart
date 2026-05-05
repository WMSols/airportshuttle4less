import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Loads and exposes env variables. Call [load] in main before runApp.
class EnvConfig {
  EnvConfig._();

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.trim().isEmpty) {
      throw StateError('Missing required env key: $key');
    }
    return value;
  }

  /// Base URL loaded from environment variable.
  static String get baseUrl => _required('BASE_URL');
  static String get googleMapsApiKey => _required('GOOGLE_MAPS_API_KEY');

  static String get apiLogin => _required('API_LOGIN');
  static String get apiRegister => _required('API_REGISTER');
  static String get apiForgotPassword => _required('API_FORGOT_PASSWORD');
  static String get apiCorporateLogin => _required('API_CORPORATE_LOGIN');
  static String get apiAddReservation => _required('API_ADD_RESERVATION');
  static String get apiApplyOffer => _required('API_APPLY_OFFER');
  static String get apiCheckEmail => _required('API_CHECK_EMAIL');
  static String get apiLoadVehicles => _required('API_LOAD_VEHICLES');
  static String get apiLoadDistanceRate => _required('API_LOAD_DISTANCE_RATE');
  static String get apiLoadHourlyRate => _required('API_LOAD_HOURLY_RATE');
  static String get apiGetA4slAirports => _required('API_GET_A4SL_AIRPORTS');
  static String get apiGetAllOffer => _required('API_GET_ALL_OFFER');
  static String get apiGetAllCustomers => _required('API_GET_ALL_CUSTOMERS');
  static String get apiAddCustomer => _required('API_ADD_CUSTOMER');
  static String get apiAddCorporateReservation =>
      _required('API_ADD_CORPORATE_RESERVATION');
  static String get apiLoadAllComment => _required('API_LOAD_ALL_COMMENT');
  static String get apiSaveComment => _required('API_SAVE_COMMENT');
  static String get apiDeleteComment => _required('API_DELETE_COMMENT');
  static String get apiEnquiryMail => _required('API_ENQUIRY_MAIL');
  static String get apiQuoteMail => _required('API_QUOTE_MAIL');

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}
