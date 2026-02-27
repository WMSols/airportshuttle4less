import '../../../domain/entities/vehicle.dart';

/// Vehicle model from API
class VehicleModel {
  final String id;
  final String name;
  final String type;
  final int capacity;
  final String imageUrl;
  final double pricePerPerson;
  final double totalPrice;
  final List<String> amenities;
  final String? description;

  const VehicleModel({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.imageUrl,
    required this.pricePerPerson,
    required this.totalPrice,
    required this.amenities,
    this.description,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      capacity: json['capacity'] ?? 1,
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      pricePerPerson: (json['price_per_person'] ?? json['pricePerPerson'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? json['totalPrice'] ?? 0).toDouble(),
      amenities: json['amenities'] != null
          ? List<String>.from(json['amenities'])
          : [],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'capacity': capacity,
      'image_url': imageUrl,
      'price_per_person': pricePerPerson,
      'total_price': totalPrice,
      'amenities': amenities,
      'description': description,
    };
  }

  Vehicle toEntity() {
    return Vehicle(
      id: id,
      name: name,
      type: type,
      capacity: capacity,
      imageUrl: imageUrl,
      pricePerPerson: pricePerPerson,
      totalPrice: totalPrice,
      amenities: amenities,
      description: description,
    );
  }

  factory VehicleModel.fromEntity(Vehicle vehicle) {
    return VehicleModel(
      id: vehicle.id,
      name: vehicle.name,
      type: vehicle.type,
      capacity: vehicle.capacity,
      imageUrl: vehicle.imageUrl,
      pricePerPerson: vehicle.pricePerPerson,
      totalPrice: vehicle.totalPrice,
      amenities: vehicle.amenities,
      description: vehicle.description,
    );
  }
}
