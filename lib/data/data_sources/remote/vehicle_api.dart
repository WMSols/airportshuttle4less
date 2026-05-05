import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/data/models/vehicle/reservation_vehicle_model.dart';

/// Vehicle API for reservation flow (SearchHandler).
class VehicleApi {
  final Dio _dio;

  VehicleApi(this._dio);

  /// Load vehicles for reservation. Tab: 1=Airport, 2=PointToPoint, 3=Hourly.
  Future<List<ReservationVehicleModel>> loadVehicles({
    required int tab,
    required int capacity,
  }) async {
    final response = await _dio.post(
      ApiConstants.loadVehicles,
      data: {'Tab': tab, 'Capacity': capacity},
    );
    final data = _unwrapAsmx(response.data);
    final retCode = data['retCode'] ?? data['RetCode'];
    if (retCode != 1 && retCode != '1') {
      return [];
    }
    final list = data['VehInfo'] ?? data['vehInfo'] ?? data['Arr'];
    if (list is! List) return [];
    return list
        .map<ReservationVehicleModel>(
          (e) => ReservationVehicleModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }

  /// Unwrap ASP.NET AJAX/ASMX payload:
  /// - { "d": { ... } }
  /// - { "d": "{\"retCode\":1,...}" }
  /// - plain map payload.
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
