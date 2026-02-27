import '../entities/vehicle.dart';
import '../repositories/vehicle_repository.dart';

/// Vehicle use case for vehicle-related operations
class VehicleUseCase {
  final VehicleRepository _repository;

  VehicleUseCase(this._repository);

  /// Get all available vehicles
  Future<List<Vehicle>> getVehicles() {
    return _repository.getVehicles();
  }

  /// Get vehicle by ID
  Future<Vehicle> getVehicleById(String id) {
    return _repository.getVehicleById(id);
  }

  /// Get vehicles by type
  Future<List<Vehicle>> getVehiclesByType(String type) {
    return _repository.getVehiclesByType(type);
  }

  /// Get vehicles by capacity
  Future<List<Vehicle>> getVehiclesByCapacity(int minCapacity) {
    return _repository.getVehiclesByCapacity(minCapacity);
  }

  /// Get featured vehicles
  Future<List<Vehicle>> getFeaturedVehicles() {
    return _repository.getFeaturedVehicles();
  }

  /// Search vehicles
  Future<List<Vehicle>> searchVehicles(String query) {
    return _repository.searchVehicles(query);
  }
}
