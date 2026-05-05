/// Request body for BookingHandler.asmx/AddReservation (PascalCase per API).
class AddReservationRequest {
  final int sid;
  final String reservationDate;
  final String service;
  final String time;
  final String source;
  final String destination;
  final String address;
  final String passenger;
  final int adults;
  final int childs;
  final int vehicleId;
  final double vehicleRate;
  final double baseCharge;
  final double distance;
  final double fare;
  final bool isMeetAndGreet;
  final bool isLateNight;
  final bool isChildSeat;
  final String childSeatType;
  final double childCharge;
  final bool isPetInCage;
  final double petInCageCharge;
  final double gratuity;
  final int extraBags;
  final double extraBagCharge;
  final double toll;
  final double parking;
  final double totalFare;
  final String offerDetail;
  final bool isPaid;
  final int driverId;
  final String driverName;
  final double driverPercent;
  final String status;
  final int hours;
  final String airlines;
  final String flightNumber;
  final bool isSnow;
  final double snow;
  final String stops;
  final bool isHalt;
  final int hourlySettingID;
  final int haltingHours;
  final double haltingDiscount;
  final double cardProcessingFee;

  const AddReservationRequest({
    this.sid = 0,
    required this.reservationDate,
    required this.service,
    required this.time,
    required this.source,
    required this.destination,
    required this.address,
    required this.passenger,
    required this.adults,
    this.childs = 0,
    required this.vehicleId,
    required this.vehicleRate,
    required this.baseCharge,
    required this.distance,
    required this.fare,
    this.isMeetAndGreet = false,
    this.isLateNight = false,
    this.isChildSeat = false,
    this.childSeatType = '',
    this.childCharge = 0,
    this.isPetInCage = false,
    this.petInCageCharge = 0,
    required this.gratuity,
    this.extraBags = 0,
    this.extraBagCharge = 0,
    this.toll = 0,
    this.parking = 0,
    required this.totalFare,
    this.offerDetail = '',
    this.isPaid = true,
    this.driverId = 0,
    this.driverName = '',
    this.driverPercent = 0,
    this.status = 'Pending',
    this.hours = 0,
    this.airlines = '',
    this.flightNumber = '',
    this.isSnow = false,
    this.snow = 0,
    this.stops = '',
    this.isHalt = false,
    this.hourlySettingID = 0,
    this.haltingHours = 0,
    this.haltingDiscount = 0,
    this.cardProcessingFee = 0,
  });

  Map<String, dynamic> toJson() => {
    'Sid': sid,
    'ReservationDate': reservationDate,
    'Service': service,
    'Time': time,
    'Source': source,
    'Destination': destination,
    'Address': address,
    'Passenger': passenger,
    'Adults': adults,
    'Childs': childs,
    'VehicleId': vehicleId,
    'VehicleRate': vehicleRate,
    'BaseCharge': baseCharge,
    'Distance': distance,
    'Fare': fare,
    'IsMeetAndGreet': isMeetAndGreet,
    'IsLateNight': isLateNight,
    'IsChildSeat': isChildSeat,
    'ChildSeatType': childSeatType,
    'ChildCharge': childCharge,
    'IsPetInCage': isPetInCage,
    'PetInCageCharge': petInCageCharge,
    'Gratuity': gratuity,
    'ExtraBags': extraBags,
    'ExtraBagCharge': extraBagCharge,
    'Toll': toll,
    'Parking': parking,
    'TotalFare': totalFare,
    'OfferDetail': offerDetail,
    'IsPaid': isPaid,
    'DriverId': driverId,
    'DriverName': driverName,
    'DriverPercent': driverPercent,
    'Status': status,
    'Hours': hours,
    'Airlines': airlines,
    'FlightNumber': flightNumber,
    'IsSnow': isSnow,
    'Snow': snow,
    'Stops': stops,
    'IsHalt': isHalt,
    'HourlySettingID': hourlySettingID,
    'HaltingHours': haltingHours,
    'HaltingDiscount': haltingDiscount,
    'CardProcessingFee': cardProcessingFee,
  };
}
