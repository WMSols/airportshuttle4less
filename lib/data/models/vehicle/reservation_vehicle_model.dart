/// Vehicle item from SearchHandler.asmx/LoadVehicles (VehInfo).
class ReservationVehicleModel {
  final int sid;
  final String model;
  final int maxCapacity;
  final int maxBaggage;
  final double baseCharge;

  const ReservationVehicleModel({
    required this.sid,
    required this.model,
    required this.maxCapacity,
    required this.maxBaggage,
    required this.baseCharge,
  });

  factory ReservationVehicleModel.fromJson(Map<String, dynamic> json) {
    final baseRaw = json['BaseCharge'] ?? json['VehicleRate'] ?? 0;
    return ReservationVehicleModel(
      sid: (json['Sid'] ?? 0) is int
          ? json['Sid'] as int
          : int.tryParse(json['Sid']?.toString() ?? '0') ?? 0,
      model: json['Model']?.toString() ?? '',
      maxCapacity: (json['MaxCapacity'] ?? 1) is int
          ? json['MaxCapacity'] as int
          : int.tryParse(json['MaxCapacity']?.toString() ?? '1') ?? 1,
      maxBaggage: (json['MaxBaggage'] ?? 1) is int
          ? json['MaxBaggage'] as int
          : int.tryParse(json['MaxBaggage']?.toString() ?? '1') ?? 1,
      baseCharge: baseRaw is num
          ? baseRaw.toDouble()
          : double.tryParse(baseRaw.toString()) ?? 0.0,
    );
  }
}
