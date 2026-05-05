import 'package:get/get.dart';

import 'package:airportshuttle4less/data/data_sources/remote/reservation_pricing_api.dart';
import 'package:airportshuttle4less/data/models/reservation/reservation_rate_models.dart';

class ReservationPricingCatalogService extends GetxService {
  final _distanceRatesByType = <String, ReservationDistanceRateModel>{};
  final _hourlyRatesByType = <String, ReservationHourlyRateModel>{};
  final _airportsByCode = <String, ReservationAirportModel>{};
  final _offersByCode = <String, ReservationOfferModel>{};

  bool _loaded = false;

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    final api = Get.find<ReservationPricingApi>();
    final results = await Future.wait([
      api.loadDistanceRates(),
      api.loadHourlyRates(),
      api.loadAirports(),
      api.loadOffers(),
    ]);

    final distanceRates = results[0] as List<ReservationDistanceRateModel>;
    final hourlyRates = results[1] as List<ReservationHourlyRateModel>;
    final airports = results[2] as List<ReservationAirportModel>;
    final offers = results[3] as List<ReservationOfferModel>;

    _distanceRatesByType
      ..clear()
      ..addEntries(distanceRates.map((e) => MapEntry(_key(e.vehTypeName), e)));
    _hourlyRatesByType
      ..clear()
      ..addEntries(hourlyRates.map((e) => MapEntry(_key(e.vehTypeName), e)));
    _offersByCode
      ..clear()
      ..addEntries(offers.map((e) => MapEntry(_key(e.code), e)));
    _airportsByCode
      ..clear()
      ..addEntries(
        airports.map((e) => MapEntry(_airportCodeFromName(e.name), e)),
      );

    _loaded = true;
  }

  ReservationDistanceRateModel? distanceRateFor(String vehicleTypeName) {
    return _distanceRatesByType[_key(vehicleTypeName)];
  }

  ReservationHourlyRateModel? hourlyRateFor(String vehicleTypeName) {
    return _hourlyRatesByType[_key(vehicleTypeName)];
  }

  ReservationAirportModel? airportByCode(String airportCode) {
    return _airportsByCode[_key(airportCode)];
  }

  ReservationOfferModel? offerByCode(String code) {
    return _offersByCode[_key(code)];
  }

  List<(String, ReservationAirportModel)> get airports {
    final items = _airportsByCode.entries
        .map((e) => (e.key.toUpperCase(), e.value))
        .toList();
    items.sort(
      (a, b) => a.$2.name.toLowerCase().compareTo(b.$2.name.toLowerCase()),
    );
    return items;
  }

  String _key(String value) => value.trim().toLowerCase();

  String _airportCodeFromName(String name) {
    final n = name.toUpperCase();
    if (n.contains('(BWI)')) return 'bwi';
    if (n.contains('(IAD)')) return 'iad';
    if (n.contains('(DCA)')) return 'dca';
    if (n.contains('(JFK)')) return 'jfk';
    if (n.contains('(LGA)')) return 'lga';
    if (n.contains('(EWR)')) return 'ewr';
    if (n.contains('(PHL)')) return 'phl';
    if (n.contains('(RIC)')) return 'ric';
    if (n.contains('(LNS)')) return 'lns';
    if (n.contains('GREENBELT')) return 'greenbelt';
    if (n.contains('PENN STATION')) return 'penn_baltimore';
    if (n.contains('UNION STATION')) return 'union_dc';
    if (n.contains('BALTIMORE SIGNATURE')) return 'bwi_signature';
    if (n.contains('IAD SIGNATURE')) return 'iad_signature';
    if (n.contains('BALTIMORE CRUISE')) return 'bwi_cruise';
    return n.toLowerCase();
  }
}
