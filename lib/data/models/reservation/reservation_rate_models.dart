class ReservationDistanceRateModel {
  const ReservationDistanceRateModel({
    required this.sid,
    required this.baseCharge,
    required this.perMile,
    required this.vehTypeName,
  });

  final int sid;
  final double baseCharge;
  final double perMile;
  final String vehTypeName;

  factory ReservationDistanceRateModel.fromJson(Map<String, dynamic> json) {
    return ReservationDistanceRateModel(
      sid: int.tryParse(json['Sid']?.toString() ?? '0') ?? 0,
      baseCharge: double.tryParse(json['BaseCharge']?.toString() ?? '0') ?? 0,
      perMile: double.tryParse(json['PerMile']?.toString() ?? '0') ?? 0,
      vehTypeName: json['VehTypeName']?.toString() ?? '',
    );
  }
}

class ReservationHourlyRateModel {
  const ReservationHourlyRateModel({
    required this.sid,
    required this.minimumHours,
    required this.perHour,
    required this.vehTypeName,
  });

  final int sid;
  final int? minimumHours;
  final double? perHour;
  final String vehTypeName;

  factory ReservationHourlyRateModel.fromJson(Map<String, dynamic> json) {
    return ReservationHourlyRateModel(
      sid: int.tryParse(json['Sid']?.toString() ?? '0') ?? 0,
      minimumHours: int.tryParse(json['MinHours']?.toString() ?? ''),
      perHour: double.tryParse(json['PerHour']?.toString() ?? ''),
      vehTypeName: json['VehTypeName']?.toString() ?? '',
    );
  }
}

class ReservationAirportModel {
  const ReservationAirportModel({
    required this.sid,
    required this.airportId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  final int sid;
  final int airportId;
  final String name;
  final double latitude;
  final double longitude;

  factory ReservationAirportModel.fromJson(Map<String, dynamic> json) {
    return ReservationAirportModel(
      sid: int.tryParse(json['Sid']?.toString() ?? '0') ?? 0,
      airportId: int.tryParse(json['AirportID']?.toString() ?? '0') ?? 0,
      name: json['Name']?.toString() ?? '',
      latitude: double.tryParse(json['Latitute']?.toString() ?? '0') ?? 0,
      longitude: double.tryParse(json['Longitude']?.toString() ?? '0') ?? 0,
    );
  }
}

class ReservationOfferModel {
  const ReservationOfferModel({
    required this.sid,
    required this.name,
    required this.code,
    required this.percent,
  });

  final int sid;
  final String name;
  final String code;
  final double percent;

  factory ReservationOfferModel.fromJson(Map<String, dynamic> json) {
    final raw = json['Percents']?.toString().replaceAll('%', '').trim() ?? '';
    return ReservationOfferModel(
      sid: int.tryParse(json['Sid']?.toString() ?? '0') ?? 0,
      name: json['Name']?.toString() ?? '',
      code: json['Code']?.toString().trim() ?? '',
      percent: double.tryParse(raw) ?? 0,
    );
  }
}
