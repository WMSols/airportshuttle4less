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
    final data = response.data;
    if (data is! Map<String, dynamic> || data['retCode'] != 1) {
      return [];
    }
    final list = data['VehInfo'];
    if (list is! List) return [];
    return list
        .map<ReservationVehicleModel>(
          (e) => ReservationVehicleModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }
}
