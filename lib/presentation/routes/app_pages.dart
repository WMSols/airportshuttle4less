import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/routes/app_routes.dart';
import 'package:airportshuttle4less/presentation/bindings/auth_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/main_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/onboarding_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/profile_binding.dart';
import 'package:airportshuttle4less/presentation/screens/auth/login_screen.dart';
import 'package:airportshuttle4less/presentation/screens/auth/register_screen.dart';
import 'package:airportshuttle4less/presentation/screens/auth/forgot_password_screen.dart';
import 'package:airportshuttle4less/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:airportshuttle4less/presentation/screens/splash/splash_screen.dart';
import 'package:airportshuttle4less/presentation/screens/main/main_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/home_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/search_ride_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/select_vehicle_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/booking_details_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/payment_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/success_screen.dart';
import 'package:airportshuttle4less/presentation/screens/my_bookings/my_bookings_screen.dart';
import 'package:airportshuttle4less/presentation/screens/my_bookings/booking_detail_screen.dart';
import 'package:airportshuttle4less/presentation/bindings/reviews_binding.dart';
import 'package:airportshuttle4less/presentation/screens/profile/leave_review_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/reviews_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/profile_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/edit_profile_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/support_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/faqs_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/contact_us_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/corporate_quote_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/terms_screen.dart';
import 'package:airportshuttle4less/presentation/screens/support/privacy_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_ride_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_select_vehicle_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_payment_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_success_screen.dart';
import 'package:airportshuttle4less/presentation/bindings/reservation_binding.dart';

/// App pages with route definitions
abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.searchRide, page: () => const SearchRideScreen()),
    GetPage(
      name: AppRoutes.selectVehicle,
      page: () => const SelectVehicleScreen(),
    ),
    GetPage(
      name: AppRoutes.bookingDetails,
      page: () => const BookingDetailsScreen(),
    ),
    GetPage(name: AppRoutes.payment, page: () => const PaymentScreen()),
    GetPage(name: AppRoutes.success, page: () => const SuccessScreen()),
    GetPage(name: AppRoutes.myBookings, page: () => const MyBookingsScreen()),
    GetPage(
      name: AppRoutes.bookingDetail,
      page: () => const BookingDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.reservation,
      page: () => const ReservationScreen(),
      binding: ReservationBinding(),
    ),
    GetPage(
      name: AppRoutes.reservationRideInfo,
      page: () => const ReservationRideInfoScreen(),
    ),
    GetPage(
      name: AppRoutes.reservationSelectVehicle,
      page: () => const ReservationSelectVehicleScreen(),
    ),
    GetPage(
      name: AppRoutes.reservationPaymentInfo,
      page: () => const ReservationPaymentInfoScreen(),
    ),
    GetPage(
      name: AppRoutes.reservationSuccess,
      page: () => const ReservationSuccessScreen(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.reviews,
      page: () => const ReviewsScreen(),
      binding: ReviewsBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveReview,
      page: () => const LeaveReviewScreen(),
      binding: ReviewsBinding(),
    ),
    GetPage(name: AppRoutes.support, page: () => const SupportScreen()),
    GetPage(name: AppRoutes.faqs, page: () => const FaqsScreen()),
    GetPage(name: AppRoutes.contactUs, page: () => const ContactUsScreen()),
    GetPage(
      name: AppRoutes.corporateQuote,
      page: () => const CorporateQuoteScreen(),
    ),
    GetPage(name: AppRoutes.terms, page: () => const TermsScreen()),
    GetPage(name: AppRoutes.privacy, page: () => const PrivacyScreen()),
  ];
}
