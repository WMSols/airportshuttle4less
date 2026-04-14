import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/presentation/controllers/main/main_navigation_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';

/// Page timers, URLs, dialer, and reservation tab jump for home marketing sections.
class HomeController extends GetxController {
  late final PageController locationPageController;
  late final PageController preferredVehiclePageController;
  late final PageController partnersPageController;

  final locationPageIndex = 0.obs;
  final preferredVehiclePageIndex = 0.obs;
  final partnersPageIndex = 0.obs;

  Timer? _locationAutoTimer;
  Timer? _preferredAutoTimer;
  Timer? _partnersAutoTimer;

  @override
  void onInit() {
    super.onInit();
    locationPageController = PageController();
    preferredVehiclePageController = PageController(
      viewportFraction: HomeConstants.preferredVehicleViewportFraction,
    );
    partnersPageController = PageController(
      viewportFraction: HomeConstants.partnersViewportFraction,
    );
    _restartLocationAutoAdvance();
    _restartPreferredAutoAdvance();
    _restartPartnersAutoAdvance();
  }

  void _restartLocationAutoAdvance() {
    _locationAutoTimer?.cancel();
    _locationAutoTimer = Timer.periodic(
      Duration(milliseconds: HomeConstants.locationAutoAdvanceMs),
      (_) {
        if (!_canUsePageController(locationPageController)) return;
        final n = HomeConstants.locationSlides.length;
        final current =
            locationPageController.page?.round() ?? locationPageIndex.value;
        final next = (current + 1) % n;
        locationPageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  void _restartPreferredAutoAdvance() {
    _preferredAutoTimer?.cancel();
    _preferredAutoTimer = Timer.periodic(
      Duration(milliseconds: HomeConstants.preferredVehicleAutoAdvanceMs),
      (_) {
        if (!_canUsePageController(preferredVehiclePageController)) return;
        final n = HomeConstants.preferredVehicles.length;
        final current =
            preferredVehiclePageController.page?.round() ??
            preferredVehiclePageIndex.value;
        final next = (current + 1) % n;
        preferredVehiclePageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  void _restartPartnersAutoAdvance() {
    _partnersAutoTimer?.cancel();
    _partnersAutoTimer = Timer.periodic(
      Duration(milliseconds: HomeConstants.partnersAutoAdvanceMs),
      (_) {
        if (!_canUsePageController(partnersPageController)) return;
        final n = HomeConstants.partners.length;
        final current =
            partnersPageController.page?.round() ?? partnersPageIndex.value;
        final next = (current + 1) % n;
        partnersPageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  bool _canUsePageController(PageController c) => c.hasClients;

  void onLocationPageChanged(int index) {
    locationPageIndex.value = index;
    _restartLocationAutoAdvance();
  }

  void onPreferredVehiclePageChanged(int index) {
    preferredVehiclePageIndex.value = index;
    _restartPreferredAutoAdvance();
  }

  void onPartnersPageChanged(int index) {
    partnersPageIndex.value = index;
    _restartPartnersAutoAdvance();
  }

  Future<void> openLocationUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> dialSupportPhone() async {
    final digits = AppTexts.contactPhone.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: '+$digits');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void openReservationTab() {
    if (Get.isRegistered<ReservationFlowController>()) {
      Get.find<ReservationFlowController>().reset();
    }
    if (Get.isRegistered<MainNavigationController>()) {
      Get.find<MainNavigationController>().jumpToTab(1);
    }
  }

  @override
  void onClose() {
    _locationAutoTimer?.cancel();
    _preferredAutoTimer?.cancel();
    _partnersAutoTimer?.cancel();
    locationPageController.dispose();
    preferredVehiclePageController.dispose();
    partnersPageController.dispose();
    super.onClose();
  }
}
