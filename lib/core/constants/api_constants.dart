/// API path segments. Full URL is composed from EnvConfig.baseUrl + path.
class ApiConstants {
  ApiConstants._();

  static const int connectTimeoutMs = 100000;
  static const int receiveTimeoutMs = 100000;

  // Auth endpoints
  static const String login = '/Handler/DefaultHandler.asmx/Login';
  static const String register = '/Handler/DefaultHandler.asmx/Register';
  static const String forgotPassword = '/Handler/DefaultHandler.asmx/MailPassword';
  static const String corporateLogin = '/Handler/DefaultHandler.asmx/CorporateLogin';

  // Booking endpoints
  static const String addReservation = '/Handler/BookingHandler.asmx/AddReservation';
  static const String applyOffer = '/Handler/BookingHandler.asmx/ApplyOffer';
  static const String checkEmail = '/Handler/BookingHandler.asmx/CheckEmail';

  // Admin endpoints
  static const String getAllCustomers = '/Admin/Handler/AdminHandler.asmx/GetAllCustomer';
  static const String addCustomer = '/Admin/Handler/AdminHandler.asmx/AddCustomer';

  // Corporate endpoints
  static const String addCorporateReservation = '/AdminCorporate/Handler/CorporativeHandler.asmx/AddReservation';

  // Support/Misc endpoints
  static const String saveComment = '/Handler/DefaultHandler.asmx/SaveComment';
  static const String quoteMail = '/Handler/DefaultHandler.asmx/QuoteMail';
}
