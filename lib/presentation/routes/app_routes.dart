/// Route names for the app
abstract class AppRoutes {
  // Splash & Onboarding
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyOtp = '/verify-otp';
  static const String resetPassword = '/reset-password';

  // Main/Home
  static const String main = '/main';
  static const String home = '/home';
  static const String searchRide = '/search-ride';
  static const String selectVehicle = '/select-vehicle';
  static const String bookingDetails = '/booking-details';
  static const String payment = '/payment';
  static const String success = '/success';

  // My Bookings
  static const String myBookings = '/my-bookings';
  static const String bookingDetail = '/booking-detail';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';

  // Support
  static const String support = '/support';
  static const String faqs = '/faqs';
  static const String contactUs = '/contact-us';
  static const String corporateQuote = '/corporate-quote';
}
