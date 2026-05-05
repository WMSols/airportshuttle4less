import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/data/models/reservation/reservation_rate_models.dart';

class ReservationPricingApi {
  ReservationPricingApi(this._dio);

  final Dio _dio;
  static final _asmxOptions = Options(
    headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'X-Requested-With': 'XMLHttpRequest',
    },
  );

  Future<List<ReservationDistanceRateModel>> loadDistanceRates() async {
    final response = await _dio.post(
      ApiConstants.loadDistanceRate,
      data: const <String, dynamic>{},
      options: _asmxOptions,
    );
    final data = _unwrapAsmx(response.data);
    final list = data['List'];
    if (list is! List) return const [];
    return list
        .map(
          (e) => ReservationDistanceRateModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<List<ReservationHourlyRateModel>> loadHourlyRates() async {
    final response = await _dio.post(
      ApiConstants.loadHourlyRate,
      data: const <String, dynamic>{},
      options: _asmxOptions,
    );
    final data = _unwrapAsmx(response.data);
    final list = data['List'];
    if (list is! List) return const [];
    return list
        .map(
          (e) => ReservationHourlyRateModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<List<ReservationAirportModel>> loadAirports() async {
    final response = await _dio.post(
      ApiConstants.getA4slAirports,
      data: const <String, dynamic>{},
      options: _asmxOptions,
    );
    final data = _unwrapAsmx(response.data);
    final list = data['Arr'] ?? data['List'];
    if (list is! List) return const [];
    return list
        .map(
          (e) => ReservationAirportModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Future<List<ReservationOfferModel>> loadOffers() async {
    final response = await _dio.post(
      ApiConstants.getAllOffer,
      data: const <String, dynamic>{},
      options: _asmxOptions,
    );
    final data = _unwrapAsmx(response.data);
    final list = data['List'];
    if (list is! List) return const [];
    return list
        .map(
          (e) => ReservationOfferModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> _unwrapAsmx(dynamic response) {
    if (response is String) {
      final decoded = jsonDecode(response);
      if (decoded is Map<String, dynamic>) return decoded;
      return <String, dynamic>{};
    }
    if (response is! Map<String, dynamic>) return <String, dynamic>{};
    final d = response['d'];
    if (d == null) return response;
    if (d is Map<String, dynamic>) return d;
    if (d is String) {
      final decoded = jsonDecode(d);
      if (decoded is Map<String, dynamic>) return decoded;
    }
    return <String, dynamic>{};
  }
}
