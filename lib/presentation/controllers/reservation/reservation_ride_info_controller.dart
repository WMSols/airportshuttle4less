import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/constants/reservation_constants.dart';
import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';
import 'package:airportshuttle4less/core/utils/reservation_distance_estimator.dart';
import 'package:airportshuttle4less/data/models/reservation/reservation_rate_models.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_tab_flow_controller.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for Ride Info step. Holds form state and submits to flow, then navigates to Select Vehicle.
class ReservationRideInfoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final passengersController = TextEditingController();
  final flightController = TextEditingController();
  final returnFlightController = TextEditingController();
  final returnPickupController = TextEditingController();
  final returnDropController = TextEditingController();

  ReservationFlowController get _flow => Get.find<ReservationFlowController>();

  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<ReservationTabFlowController>()) {
      _flow.reset();
    }
    Get.find<ReservationPricingCatalogService>().ensureLoaded();
    _hydrateInputsFromFlow();
  }

  void _hydrateInputsFromFlow() {
    pickupController.text = _flow.pickupAddress.value;
    dropController.text = _flow.dropAddress.value;
    passengersController.text = _flow.passengers.value.toString();
    flightController.text = _flow.flightNumber.value;
    returnFlightController.text = _flow.returnFlightNumber.value;
    returnPickupController.text = _flow.returnPickupAddress.value;
    returnDropController.text = _flow.returnDropAddress.value;
  }

  void setServiceDirection(bool? toAirport) {
    _flow.toFromAirport.value = toAirport ?? true;
  }

  void setAirportSelection(
    String? airportId,
    Map<String, String> airportLabel,
  ) {
    if (airportId == null) return;
    final normalizedId = airportId.trim().toUpperCase();
    _flow.airportId.value = normalizedId;
    _flow.airportName.value = airportLabel[normalizedId] ?? '';
  }

  void setPickupAddress(String value) => _flow.pickupAddress.value = value;
  void setDropAddress(String value) => _flow.dropAddress.value = value;
  void setPassengerCount(String value) =>
      _flow.passengers.value = int.tryParse(value) ?? 1;

  void setPickupDate(DateTime d) {
    final current = _flow.pickupDateTime ?? DateTime.now();
    _flow.setPickupFromDateTime(
      DateTime(d.year, d.month, d.day, current.hour, current.minute),
    );
  }

  void setPickupDateTime(DateTime d) => _flow.setPickupFromDateTime(d);
  void setReturnDateTime(DateTime d) => _flow.setReturnFromDateTime(d);

  void setReturnDate(DateTime d) {
    final current = _flow.returnDateTime ?? DateTime.now();
    _flow.setReturnFromDateTime(
      DateTime(d.year, d.month, d.day, current.hour, current.minute),
    );
  }

  void setFlightNumber(String value) => _flow.flightNumber.value = value;
  void setReturnFlightNumber(String value) =>
      _flow.returnFlightNumber.value = value;
  void setAirline(String? airline) {
    if (airline == null) return;
    _flow.airlines.value = airline;
  }

  void setReturnAirline(String? airline) {
    if (airline == null) return;
    _flow.returnAirlines.value = airline;
  }

  void toggleReturnReservation(bool value) => _flow.isReturn.value = value;
  void setReturnPickupAddress(String value) =>
      _flow.returnPickupAddress.value = value;
  void setReturnDropAddress(String value) =>
      _flow.returnDropAddress.value = value;
  void setPtpPickup(String value) => _flow.ptpPickup.value = value;
  void setPtpDrop(String value) => _flow.ptpDrop.value = value;
  void setHourlyPickup(String value) => _flow.hourlyPickup.value = value;
  void setHourlyDrop(String value) => _flow.hourlyDrop.value = value;
  void setHourlyHours(int? value) => _flow.hourlyHours.value = value ?? 3;
  void setServiceType(ReservationServiceType type) =>
      _flow.serviceType.value = type;

  ({List<String> items, Map<String, String> labels, String? selectedValue})
  airportOptions(List<(String, ReservationAirportModel)> apiAirports) {
    final airportItems = <String>[];
    final airportLabel = <String, String>{};
    final seen = <String>{};

    void addAirport(String id, String name) {
      final key = id.trim().toUpperCase();
      if (key.isEmpty) return;
      final normalized = key.toLowerCase();
      if (seen.contains(normalized)) return;
      seen.add(normalized);
      airportItems.add(key);
      airportLabel[key] = name;
    }

    if (apiAirports.isNotEmpty) {
      for (final e in apiAirports) {
        addAirport(e.$1, e.$2.name);
      }
    } else {
      for (final a in ReservationConstants.airports) {
        addAirport(a.$1, a.$2);
      }
    }

    final selectedAirportId = _flow.airportId.value.trim().toUpperCase();
    final selectedMatches = selectedAirportId.isEmpty
        ? const <String>[]
        : airportItems
              .where(
                (id) => id.toLowerCase() == selectedAirportId.toLowerCase(),
              )
              .toList();
    final selectedValue = selectedMatches.length == 1
        ? selectedMatches.first
        : null;

    return (
      items: airportItems,
      labels: airportLabel,
      selectedValue: selectedValue,
    );
  }

  @override
  void onClose() {
    pickupController.dispose();
    dropController.dispose();
    passengersController.dispose();
    flightController.dispose();
    returnFlightController.dispose();
    returnPickupController.dispose();
    returnDropController.dispose();
    super.onClose();
  }

  Future<void> submitSearch() async {
    if (!formKey.currentState!.validate()) return;
    await Get.find<ReservationPricingCatalogService>().ensureLoaded();

    final type = _flow.serviceType.value;

    if (type == ReservationServiceType.airport) {
      if (_flow.toFromAirport.value) {
        _flow.pickupAddress.value = pickupController.text.trim();
        _flow.dropAddress.value = _flow.airportName.value;
      } else {
        _flow.pickupAddress.value = _flow.airportName.value;
        _flow.dropAddress.value = dropController.text.trim();
      }
    } else if (type == ReservationServiceType.pointToPoint) {
      _flow.pickupAddress.value = pickupController.text.trim();
      _flow.dropAddress.value = dropController.text.trim();
      _flow.returnPickupAddress.value = returnPickupController.text.trim();
      _flow.returnDropAddress.value = returnDropController.text.trim();
    } else if (type == ReservationServiceType.hourly) {
      _flow.pickupAddress.value = pickupController.text.trim();
      _flow.dropAddress.value = dropController.text.trim();
    }

    _flow.passengers.value = int.tryParse(passengersController.text) ?? 1;
    _flow.flightNumber.value = flightController.text.trim();
    _flow.returnFlightNumber.value = returnFlightController.text.trim();
    _flow.airlines.value = _flow.airlines.value.trim();
    _flow.returnAirlines.value = _flow.returnAirlines.value.trim();
    if (_flow.flightNumber.value.isEmpty &&
        _flow.returnFlightNumber.value.isNotEmpty) {
      _flow.flightNumber.value = _flow.returnFlightNumber.value;
    }
    if (_flow.airlines.value.isEmpty && _flow.returnAirlines.value.isNotEmpty) {
      _flow.airlines.value = _flow.returnAirlines.value;
    }

    if (type == ReservationServiceType.hourly) {
      _flow.distanceMiles.value = 0;
    } else if (type == ReservationServiceType.airport) {
      final toAirport = _flow.toFromAirport.value;
      _flow.distanceMiles.value = ReservationDistanceEstimator.estimateMiles(
        fromAddress: _flow.pickupAddress.value,
        toAddress: _flow.dropAddress.value,
        fromAirportId: toAirport ? null : _flow.airportId.value,
        toAirportId: toAirport ? _flow.airportId.value : null,
      );
    } else {
      _flow.distanceMiles.value = ReservationDistanceEstimator.estimateMiles(
        fromAddress: _flow.pickupAddress.value,
        toAddress: _flow.dropAddress.value,
      );
    }

    _flow.costPerMile.value = 0;
    _flow.subtotalFare.value = 0;
    _flow.recomputeTotals();

    if (Get.isRegistered<ReservationTabFlowController>()) {
      Get.find<ReservationTabFlowController>().onRideInfoSubmitted();
      return;
    }
    Get.toNamed(AppRoutes.reservationSelectVehicle);
  }

  void clearInputs() {
    pickupController.clear();
    dropController.clear();
    passengersController.clear();
    flightController.clear();
    returnFlightController.clear();
    returnPickupController.clear();
    returnDropController.clear();
  }
}
