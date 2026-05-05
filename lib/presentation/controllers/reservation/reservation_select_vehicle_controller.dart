import 'package:get/get.dart';

import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';
import 'package:airportshuttle4less/core/utils/app_helper/app_helper.dart';
import 'package:airportshuttle4less/core/utils/reservation_pricing_engine.dart';
import 'package:airportshuttle4less/data/data_sources/remote/vehicle_api.dart';
import 'package:airportshuttle4less/data/models/vehicle/reservation_vehicle_model.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_tab_flow_controller.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for Select Vehicle step. Loads vehicles and handles Book Now.
class ReservationSelectVehicleController extends GetxController {
  final vehicles = <ReservationVehicleModel>[].obs;
  final loading = true.obs;
  final error = Rxn<String>();

  ReservationFlowController get _flow => Get.find<ReservationFlowController>();

  @override
  void onReady() {
    super.onReady();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    final type = _flow.serviceType.value;
    final tab = type.index + 1;
    final capacity = _flow.passengers.value;

    loading.value = true;
    error.value = null;

    try {
      await Get.find<ReservationPricingCatalogService>().ensureLoaded();
      final api = Get.find<VehicleApi>();
      final list = await api.loadVehicles(tab: tab, capacity: capacity);
      vehicles.value = list;
    } catch (e) {
      vehicles.clear();
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  void bookNow(ReservationVehicleModel vehicle) {
    _flow.selectedVehicleId.value = vehicle.sid;
    _flow.selectedVehicleName.value = vehicle.model;
    _flow.selectedVehicleBaseCharge.value = vehicle.baseCharge;
    _flow.selectedVehicleCapacity.value = vehicle.maxCapacity;
    _flow.selectedVehicleMaxBaggage.value = vehicle.maxBaggage;

    final pricingKey = vehicle.model.vehiclePricingKey;
    final catalog = Get.find<ReservationPricingCatalogService>();
    if (_flow.serviceType.value == ReservationServiceType.hourly) {
      final result = ReservationPricingEngine.calculateHourly(
        pricingKey: pricingKey,
        selectedHours: _flow.hourlyHours.value,
        fallbackBaseCharge: vehicle.baseCharge,
        catalog: catalog,
      );
      _flow.distanceMiles.value = 0;
      _flow.costPerMile.value = 0;
      _flow.subtotalFare.value = result.subtotal;
    } else {
      final result = ReservationPricingEngine.calculateDistanceBased(
        pricingKey: pricingKey,
        distanceMiles: _flow.distanceMiles.value,
        fallbackBaseCharge: vehicle.baseCharge,
        catalog: catalog,
      );
      _flow.costPerMile.value = result.perMileRate;
      _flow.subtotalFare.value = result.subtotal;
    }

    _flow.recomputeTotals();
    if (Get.isRegistered<ReservationTabFlowController>()) {
      Get.find<ReservationTabFlowController>().onVehicleSelected();
      return;
    }
    Get.toNamed(AppRoutes.reservationPaymentInfo);
  }

  void clearSelectionState() {
    vehicles.clear();
    loading.value = false;
    error.value = null;
  }
}
