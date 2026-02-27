import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../data_sources/remote/vehicle_api.dart';

/// Vehicle repository implementation
/// No vehicle endpoints are documented in the API documentation
class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleApi _api;

  VehicleRepositoryImpl({required VehicleApi api}) : _api = api;

  @override
  Future<List<Vehicle>> getVehicles() async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<Vehicle> getVehicleById(String id) async {
    // Not documented - throw exception
    throw Exception('Vehicle endpoint not documented');
  }

  @override
  Future<List<Vehicle>> getVehiclesByType(String type) async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<List<Vehicle>> getVehiclesByCapacity(int minCapacity) async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<List<Vehicle>> getFeaturedVehicles() async {
    // Not documented - return empty list
    return [];
  }

  @override
  Future<List<Vehicle>> searchVehicles(String query) async {
    // Not documented - return empty list
    return [];
  }
}
