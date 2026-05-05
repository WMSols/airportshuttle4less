import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';

class ReservationPricingEngine {
  ReservationPricingEngine._();

  static HourlyCalculationResult calculateHourly({
    required String pricingKey,
    required int selectedHours,
    required double fallbackBaseCharge,
    required ReservationPricingCatalogService catalog,
  }) {
    final cfg = catalog.hourlyRateFor(pricingKey);
    if (cfg == null || cfg.minimumHours == null || cfg.perHour == null) {
      return HourlyCalculationResult(
        subtotal: fallbackBaseCharge,
        appliedHours: selectedHours,
        hourlyRate: 0,
      );
    }
    final minHours = cfg.minimumHours!;
    final perHour = cfg.perHour!;
    final applied = selectedHours < minHours ? minHours : selectedHours;
    return HourlyCalculationResult(
      subtotal: perHour * applied,
      appliedHours: applied,
      hourlyRate: perHour,
    );
  }

  static DistanceCalculationResult calculateDistanceBased({
    required String pricingKey,
    required double distanceMiles,
    required double fallbackBaseCharge,
    required ReservationPricingCatalogService catalog,
  }) {
    final cfg = catalog.distanceRateFor(pricingKey);
    if (cfg == null) {
      return DistanceCalculationResult(
        subtotal: fallbackBaseCharge,
        perMileRate: 0,
      );
    }

    if (distanceMiles <= 0) {
      return DistanceCalculationResult(
        subtotal: fallbackBaseCharge,
        perMileRate: cfg.perMile,
      );
    }

    return DistanceCalculationResult(
      subtotal: cfg.baseCharge + (distanceMiles * cfg.perMile),
      perMileRate: cfg.perMile,
    );
  }
}

class HourlyCalculationResult {
  const HourlyCalculationResult({
    required this.subtotal,
    required this.appliedHours,
    required this.hourlyRate,
  });

  final double subtotal;
  final int appliedHours;
  final double hourlyRate;
}

class DistanceCalculationResult {
  const DistanceCalculationResult({
    required this.subtotal,
    required this.perMileRate,
  });

  final double subtotal;
  final double perMileRate;
}
