import 'package:dio/dio.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/data/models/vehicle/reservation_vehicle_model.dart';

/// Vehicle API for reservation flow (SearchHandler).
class VehicleApi {
  final Dio _dio;

  VehicleApi(this._dio);

  /// Load vehicles for reservation. Tab: 1=Airport, 2=PointToPoint, 3=Hourly, 4=Fredrick.
  Future<List<ReservationVehicleModel>> loadVehicles({
    required int tab,
    required int capacity,
  }) async {
    final response = await _dio.post(
      ApiConstants.loadVehicles,
      data: {'Tab': tab, 'Capacity': capacity},
    );
    final data = response.data;
    if (data is! Map<String, dynamic> || data['retCode'] != 1) {
      return [];
    }
    final list = data['VehInfo'];
    if (list is! List) return [];
    return list
        .map<ReservationVehicleModel>((e) =>
            ReservationVehicleModel.fromJson(
                Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  /// Load Fredrick cars (Fredrick Special Services).
  Future<List<ReservationVehicleModel>> loadFredrickCars({
    required String service,
    required String tab,
    required int from,
    required int to,
    required int passengers,
  }) async {
    final response = await _dio.post(
      ApiConstants.loadFredrickCars,
      data: {
        'Service': service,
        'Tab': tab,
        'From': from,
        'To': to,
        'Passengers': passengers,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic> || data['retCode'] != 1) {
      return [];
    }
    final list = data['VehInfo'];
    if (list is! List) return [];
    return list
        .map<ReservationVehicleModel>((e) {
          final m = Map<String, dynamic>.from(e as Map);
          return ReservationVehicleModel(
            sid: (m['Sid'] ?? 0) is int ? m['Sid'] as int : int.tryParse(m['Sid']?.toString() ?? '0') ?? 0,
            model: m['VehicleModel']?.toString() ?? m['Model']?.toString() ?? '',
            maxCapacity: (m['MaxCapacity'] ?? 1) is int ? m['MaxCapacity'] as int : int.tryParse(m['MaxCapacity']?.toString() ?? '1') ?? 1,
            maxBaggage: (m['MaxBaggage'] ?? 1) is int ? m['MaxBaggage'] as int : int.tryParse(m['MaxBaggage']?.toString() ?? '1') ?? 1,
            baseCharge: (m['BaseRate'] ?? m['BaseCharge'] ?? 0).toDouble(),
          );
        })
        .toList();
  }
}
