import '../entities/vehicle.dart';

/// Vehicle repository interface defining vehicle-related operations
abstract class VehicleRepository {
  /// Get all available vehicles
  Future<List<Vehicle>> getVehicles();

  /// Get vehicle by ID
  Future<Vehicle> getVehicleById(String id);

  /// Get vehicles by type (sedan, suv, van, bus)
  Future<List<Vehicle>> getVehiclesByType(String type);

  /// Get vehicles by capacity
  Future<List<Vehicle>> getVehiclesByCapacity(int minCapacity);

  /// Get featured/popular vehicles
  Future<List<Vehicle>> getFeaturedVehicles();

  /// Search vehicles by name or description
  Future<List<Vehicle>> searchVehicles(String query);
}
