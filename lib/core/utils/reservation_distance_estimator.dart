import 'dart:math' as math;

import 'package:get/get.dart';

import 'package:airportshuttle4less/core/services/reservation_pricing_catalog_service.dart';

typedef ReservationGeocodeHook = ReservationLatLng? Function(String query);

class ReservationDistanceEstimator {
  ReservationDistanceEstimator._();

  /// Optional hook for real geocoding integration.
  /// Example: wire Google/Mapbox/geocoding API and return coordinates.
  static ReservationGeocodeHook? geocodeHook;

  static double estimateMiles({
    required String fromAddress,
    required String toAddress,
    String? fromAirportId,
    String? toAirportId,
  }) {
    final from = _resolveLatLng(fromAddress, airportId: fromAirportId);
    final to = _resolveLatLng(toAddress, airportId: toAirportId);
    if (from == null || to == null) return 0;

    final straightLineMiles = _haversineMiles(from, to);
    final roadAdjusted = straightLineMiles * 1.23;
    return double.parse(roadAdjusted.toStringAsFixed(2));
  }

  static ReservationLatLng? _resolveLatLng(
    String address, {
    String? airportId,
  }) {
    if (airportId != null && airportId.trim().isNotEmpty) {
      if (Get.isRegistered<ReservationPricingCatalogService>()) {
        final airport = Get.find<ReservationPricingCatalogService>()
            .airportByCode(airportId);
        if (airport != null) {
          return ReservationLatLng(airport.latitude, airport.longitude);
        }
      }
    }

    final normalized = address.toLowerCase().trim();
    for (final entry in _keywordLatLng.entries) {
      if (normalized.contains(entry.key)) return entry.value;
    }

    final hooked = geocodeHook?.call(address);
    if (hooked != null) return hooked;

    return _mockLatLngFromText(address);
  }

  static ReservationLatLng _mockLatLngFromText(String query) {
    final hash = query.toLowerCase().trim().runes.fold<int>(
      17,
      (acc, rune) => acc * 31 + rune,
    );
    final lat = 36.0 + (hash.abs() % 4500) / 1000.0; // 36.0..40.499
    final lng = -79.5 + (hash.abs() % 6500) / 1000.0; // -79.5..-73.001
    return ReservationLatLng(lat, lng);
  }

  static double _haversineMiles(ReservationLatLng a, ReservationLatLng b) {
    const earthRadiusKm = 6371.0;
    final dLat = _degToRad(b.lat - a.lat);
    final dLon = _degToRad(b.lng - a.lng);
    final lat1 = _degToRad(a.lat);
    final lat2 = _degToRad(b.lat);

    final hav =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(hav), math.sqrt(1 - hav));
    final km = earthRadiusKm * c;
    return km * 0.621371;
  }

  static double _degToRad(double deg) => deg * (math.pi / 180);
}

class ReservationLatLng {
  const ReservationLatLng(this.lat, this.lng);
  final double lat;
  final double lng;
}

const Map<String, ReservationLatLng> _keywordLatLng = {
  'washington dc': ReservationLatLng(38.9072, -77.0369),
  'alexandria': ReservationLatLng(38.8048, -77.0469),
  'arlington': ReservationLatLng(38.8816, -77.0910),
  'baltimore': ReservationLatLng(39.2904, -76.6122),
  'springfield': ReservationLatLng(38.7893, -77.1872),
  'annapolis': ReservationLatLng(38.9784, -76.4922),
  'fairfax': ReservationLatLng(38.8462, -77.3064),
  'leesburg': ReservationLatLng(39.1157, -77.5636),
  'stafford': ReservationLatLng(38.4221, -77.4083),
  'waldorf': ReservationLatLng(38.6240, -76.9391),
  'gaithersburg': ReservationLatLng(39.1434, -77.2014),
  'oxon hill': ReservationLatLng(38.8035, -77.0033),
  'columbia': ReservationLatLng(39.2037, -76.8610),
  'bethesda': ReservationLatLng(38.9847, -77.0947),
  'annandale': ReservationLatLng(38.8304, -77.1964),
  'great falls': ReservationLatLng(38.9982, -77.2883),
  'mclean': ReservationLatLng(38.9343, -77.1775),
  'falls church': ReservationLatLng(38.8823, -77.1711),
  'idylwood': ReservationLatLng(38.8965, -77.1694),
  'lincolnia': ReservationLatLng(38.8293, -77.1344),
  'oakton': ReservationLatLng(38.8804, -77.3005),
  'potomac': ReservationLatLng(39.0182, -77.2086),
  'tysons': ReservationLatLng(38.9187, -77.2311),
  'west falls church': ReservationLatLng(38.9007, -77.1883),
  'wolf trap': ReservationLatLng(38.9392, -77.2869),
  'silver spring': ReservationLatLng(38.9907, -77.0261),
  'new york': ReservationLatLng(40.7128, -74.0060),
  'boston': ReservationLatLng(42.3601, -71.0589),
  'atlanta': ReservationLatLng(33.7490, -84.3880),
  'los angeles': ReservationLatLng(34.0522, -118.2437),
};
