/// Location entity for pickup and dropoff points
class Location {
  final String id;
  final String address;
  final String? airportName;
  final String? city;
  final double latitude;
  final double longitude;
  final String? postalCode;
  final String? country;

  const Location({
    required this.id,
    required this.address,
    this.airportName,
    this.city,
    required this.latitude,
    required this.longitude,
    this.postalCode,
    this.country,
  });

  bool get isAirport => airportName != null && airportName!.isNotEmpty;

  String get displayName {
    if (airportName != null && airportName!.isNotEmpty) {
      return airportName!;
    }
    return address;
  }

  String get shortAddress {
    if (city != null && city!.isNotEmpty) {
      return city!;
    }
    return address.length > 30 ? '${address.substring(0, 30)}...' : address;
  }

  Location copyWith({
    String? id,
    String? address,
    String? airportName,
    String? city,
    double? latitude,
    double? longitude,
    String? postalCode,
    String? country,
  }) {
    return Location(
      id: id ?? this.id,
      address: address ?? this.address,
      airportName: airportName ?? this.airportName,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
