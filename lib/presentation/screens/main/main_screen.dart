import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/presentation/screens/home/home_screen.dart';
import 'package:airportshuttle4less/presentation/screens/my_bookings/my_bookings_screen.dart';
import 'package:airportshuttle4less/presentation/screens/profile/profile_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_screen.dart';

/// Main screen with persistent bottom navigation (Style 7).
/// Support (FAQs, Contact Us, Corporate Quotes) is accessed from Profile.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() => const [
    HomeScreen(),
    MyBookingsScreen(),
    ReservationScreen(),
    ProfileScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.home_2),
      inactiveIcon: const Icon(Iconsax.home_1),
      title: 'Home',
      activeColorPrimary: AppColors.primary,
      activeColorSecondary: AppColors.white,
      inactiveColorPrimary: AppColors.white,
      inactiveColorSecondary: AppColors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.book_1),
      inactiveIcon: const Icon(Iconsax.book),
      title: 'My Bookings',
      activeColorPrimary: AppColors.primary,
      activeColorSecondary: AppColors.white,
      inactiveColorPrimary: AppColors.white,
      inactiveColorSecondary: AppColors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.calendar_tick),
      inactiveIcon: const Icon(Iconsax.calendar),
      title: 'Reservation',
      activeColorPrimary: AppColors.primary,
      activeColorSecondary: AppColors.white,
      inactiveColorPrimary: AppColors.white,
      inactiveColorSecondary: AppColors.white,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Iconsax.user),
      inactiveIcon: const Icon(Iconsax.user),
      title: 'Profile',
      activeColorPrimary: AppColors.primary,
      activeColorSecondary: AppColors.white,
      inactiveColorPrimary: AppColors.white,
      inactiveColorSecondary: AppColors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarItems(),
      navBarStyle: NavBarStyle.style7,
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      handleAndroidBackButtonPress: true,
      confineToSafeArea: true,
      decoration: const NavBarDecoration(colorBehindNavBar: AppColors.white),
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
