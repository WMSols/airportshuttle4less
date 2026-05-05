import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/data/data_sources/remote/booking_api.dart';
import 'package:airportshuttle4less/data/models/booking/add_reservation_request.dart';
import 'package:airportshuttle4less/domain/entities/user.dart';
import 'package:airportshuttle4less/domain/use_cases/auth_use_case.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for Payment Info step. Apply offer, build request, submit booking.
class ReservationPaymentInfoController extends GetxController {
  static const double lateNightChargeAmount = 10.0;
  static const double extraBagUnitChargeAmount = 10.0;
  static const double parkingChargeAmount = 10.0;
  static const double tollChargeAmount = 5.0;
  static const List<int> gratuityOptions = [15, 20, 25, 30, 35, 40, 45, 50];
  static const List<String> childSeatOptions = ['Infant', 'Toddler'];

  final remarkController = TextEditingController();
  final offerController = TextEditingController();
  final user = Rxn<User>();

  final submitting = false.obs;
  final submitError = Rxn<String>();

  ReservationFlowController get _flow => Get.find<ReservationFlowController>();
  AuthUseCase get _authUseCase => Get.find<AuthUseCase>();

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  @override
  void onReady() {
    super.onReady();
    _recomputeExtras();
  }

  @override
  void onClose() {
    remarkController.dispose();
    offerController.dispose();
    super.onClose();
  }

  Future<void> _loadUser() async {
    final currentUser = await _authUseCase.getCurrentUser();
    user.value = currentUser;
    if (currentUser == null) return;

    final nameParts = currentUser.name.trim().split(RegExp(r'\s+'));
    _flow.firstName.value = nameParts.isNotEmpty ? nameParts.first : '';
    _flow.lastName.value = nameParts.length > 1
        ? nameParts.sublist(1).join(' ')
        : '';
    _flow.phone.value = currentUser.phone.trim();
    _flow.email.value = currentUser.email.trim();
    if (_flow.alternativePhone.value.isEmpty) {
      _flow.alternativePhone.value = currentUser.phone.trim();
    }
  }

  void toggleMeetAndGreet(bool enabled) {
    _flow.isMeetAndGreet.value = enabled;
    _recomputeExtras();
  }

  void togglePetInCage(bool enabled) {
    _flow.isPetInCage.value = enabled;
    _recomputeExtras();
  }

  void toggleSnow(bool enabled) {
    _flow.isSnow.value = enabled;
    _recomputeExtras();
  }

  void setChildSeatType(String? seatType) {
    final value = (seatType ?? '').trim();
    _flow.childSeatType.value = value;
    _flow.isChildSeat.value = value.isNotEmpty;
    _recomputeExtras();
  }

  void setExtraBags(int? count) {
    _flow.extraBags.value = count ?? 0;
    _recomputeExtras();
  }

  void setGratuityPercent(int? percent) {
    if (percent == null) return;
    _flow.gratuityPercent.value = percent;
    _flow.recomputeTotals();
  }

  void setTermsAccepted(bool accepted) {
    _flow.acceptTerms.value = accepted;
  }

  void _recomputeExtras() {
    final pickupHour = _flow.pickupDateTime?.hour;
    final isLateNightAuto = pickupHour != null && pickupHour < 6;
    _flow.isLateNight.value = isLateNightAuto;

    // Keep legacy extras persisted for backend compatibility but
    // compute active pricing from the updated booking rules.
    _flow.meetAndGreetCharge.value = 0.0;
    _flow.petInCageCharge.value = 0.0;
    _flow.snowCharge.value = 0.0;
    _flow.childSeatCharge.value = 0.0;
    _flow.lateNightCharge.value = isLateNightAuto ? lateNightChargeAmount : 0.0;
    _flow.extraBagCharge.value =
        _flow.extraBags.value * extraBagUnitChargeAmount;
    _flow.parkingCharge.value = parkingChargeAmount;
    _flow.tollCharge.value = tollChargeAmount;
    _flow.recomputeTotals();
  }

  void clearInputs() {
    remarkController.clear();
    offerController.clear();
    submitError.value = null;
    submitting.value = false;
  }

  Future<void> applyOffer() async {
    final code = offerController.text.trim();
    if (code.isEmpty) return;
    final catalog = Get.find<ReservationPricingCatalogService>();
    await catalog.ensureLoaded();
    final offer = catalog.offerByCode(code);
    if (offer == null || offer.percent <= 0) return;

    _flow.offerCode.value = offer.code;
    _flow.offerDiscount.value =
        _flow.subtotalFare.value * (offer.percent / 100);
    _flow.recomputeTotals();
  }

  Future<void> completeBooking() async {
    if (!_flow.acceptTerms.value) {
      Get.snackbar(AppTexts.requiredLabel, AppTexts.pleaseAcceptTerms);
      return;
    }
    _flow.remark.value = remarkController.text.trim();

    if (_flow.firstName.value.isEmpty ||
        _flow.phone.value.isEmpty ||
        _flow.email.value.isEmpty) {
      Get.snackbar(
        AppTexts.requiredLabel,
        'Missing profile details (name, phone, email).',
      );
      return;
    }

    submitting.value = true;
    submitError.value = null;

    try {
      final request = AddReservationRequest(
        reservationDate: _flow.pickupDateFormatted,
        service: serviceLabel,
        time: _flow.pickupTimeFormatted,
        source: _flow.pickupAddress.value,
        destination: _flow.dropAddress.value,
        address: _flow.pickupAddress.value,
        passenger: '${_flow.firstName.value} ${_flow.lastName.value}',
        adults: _flow.passengers.value,
        vehicleId: _flow.selectedVehicleId.value,
        vehicleRate: _flow.selectedVehicleBaseCharge.value,
        baseCharge: _flow.selectedVehicleBaseCharge.value,
        distance: _flow.distanceMiles.value,
        fare: _flow.effectiveSubTotal,
        isMeetAndGreet: _flow.isMeetAndGreet.value,
        isLateNight: _flow.isLateNight.value,
        isChildSeat: _flow.isChildSeat.value,
        childSeatType: _flow.childSeatType.value,
        childCharge: _flow.childSeatCharge.value,
        isPetInCage: _flow.isPetInCage.value,
        petInCageCharge: _flow.petInCageCharge.value,
        gratuity: _flow.gratuityAmount,
        extraBags: _flow.extraBags.value,
        extraBagCharge: _flow.extraBagCharge.value,
        toll: _flow.tollCharge.value,
        parking: _flow.parkingCharge.value,
        totalFare: _flow.totalFare.value,
        offerDetail: _flow.offerCode.value,
        airlines: _flow.airlines.value,
        flightNumber: _flow.flightNumber.value,
        isSnow: _flow.isSnow.value,
        snow: _flow.snowCharge.value,
        cardProcessingFee: _flow.cardProcessingFeeAmount.value,
      );

      final api = Get.find<BookingApi>();
      final response = await api.addReservation(request);
      submitting.value = false;
      if (response['retCode'] == 1) {
        final ref = response['ReservationId']?.toString() ?? 'Confirmed';
        Get.offAllNamed(
          AppRoutes.reservationSuccess,
          arguments: {'reservationId': ref},
        );
      } else {
        submitError.value =
            response['message']?.toString() ?? AppTexts.bookingFailed;
      }
    } catch (e) {
      submitting.value = false;
      submitError.value = e.toString();
    }
  }

  String get serviceLabel {
    switch (_flow.serviceType.value) {
      case ReservationServiceType.airport:
        return AppTexts.airportTransfer;
      case ReservationServiceType.pointToPoint:
        return AppTexts.pointToPoint;
      case ReservationServiceType.hourly:
        return AppTexts.hourly;
    }
  }
}
