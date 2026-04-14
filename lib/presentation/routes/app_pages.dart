import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/routes/app_routes.dart';
import 'package:airportshuttle4less/presentation/bindings/auth_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/home_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/all_locations_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/all_services_binding.dart';
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
import 'package:airportshuttle4less/presentation/screens/home/all_locations_screen.dart';
import 'package:airportshuttle4less/presentation/screens/home/all_services_screen.dart';
import 'package:airportshuttle4less/presentation/screens/my_bookings/my_bookings_screen.dart';
import 'package:airportshuttle4less/presentation/screens/my_bookings/booking_detail_screen.dart';
import 'package:airportshuttle4less/presentation/bindings/reviews_binding.dart';
import 'package:airportshuttle4less/presentation/screens/profile/review/leave_review_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/review/reviews_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/profile_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/edit/edit_profile_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/faqs/faqs_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/contact/contact_us_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/corporate/corporate_quote_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/legal/terms_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/legal/privacy_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_ride_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_select_vehicle_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_payment_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_success_screen.dart';
import 'package:airportshuttle4less/presentation/bindings/reservation_select_vehicle_binding.dart';
import 'package:airportshuttle4less/presentation/bindings/reservation_payment_info_binding.dart';

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
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.allLocations,
      page: () => const AllLocationsScreen(),
      binding: AllLocationsBinding(),
    ),
    GetPage(
      name: AppRoutes.allServices,
      page: () => const AllServicesScreen(),
      binding: AllServicesBinding(),
    ),
    GetPage(name: AppRoutes.myBookings, page: () => const MyBookingsScreen()),
    GetPage(
      name: AppRoutes.bookingDetail,
      page: () => const BookingDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.reservationRideInfo,
      page: () => const ReservationRideInfoScreen(),
    ),
    GetPage(
      name: AppRoutes.reservationSelectVehicle,
      page: () => const ReservationSelectVehicleScreen(),
      binding: ReservationSelectVehicleBinding(),
    ),
    GetPage(
      name: AppRoutes.reservationPaymentInfo,
      page: () => const ReservationPaymentInfoScreen(),
      binding: ReservationPaymentInfoBinding(),
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
