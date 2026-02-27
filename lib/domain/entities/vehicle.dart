/// Vehicle entity for shuttle options
class Vehicle {
  final String id;
  final String name;
  final String type;
  final int capacity;
  final String imageUrl;
  final double pricePerPerson;
  final double totalPrice;
  final List<String> amenities;
  final String? description;

  const Vehicle({
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

  bool get isSedan => type.toLowerCase() == 'sedan';
  bool get isSuv => type.toLowerCase() == 'suv';
  bool get isVan => type.toLowerCase() == 'van';
  bool get isBus => type.toLowerCase() == 'bus';

  bool get hasAc => amenities.any((a) => a.toLowerCase().contains('ac'));
  bool get hasWifi => amenities.any((a) => a.toLowerCase().contains('wifi'));
  bool get hasLuggage => amenities.any((a) => a.toLowerCase().contains('luggage'));

  int get availableSeats => capacity;

  Vehicle copyWith({
    String? id,
    String? name,
    String? type,
    int? capacity,
    String? imageUrl,
    double? pricePerPerson,
    double? totalPrice,
    List<String>? amenities,
    String? description,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      capacity: capacity ?? this.capacity,
      imageUrl: imageUrl ?? this.imageUrl,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      totalPrice: totalPrice ?? this.totalPrice,
      amenities: amenities ?? this.amenities,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vehicle && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
