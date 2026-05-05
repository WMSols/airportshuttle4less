import 'package:get/get.dart';

/// Service type for reservation flow (matches website tabs).
enum ReservationServiceType { airport, pointToPoint, hourly }

/// Holds state across the 3-step reservation flow: Ride Info → Select Vehicle → Payment Info.
class ReservationFlowController extends GetxController {
  // ----- Step 1: Ride Info -----
  final serviceType = ReservationServiceType.airport.obs;

  // Airport
  final toFromAirport = true.obs; // true = To Airport, false = From Airport
  final airportId = ''.obs;
  final airportName = ''.obs;
  final pickupAddress = ''.obs;
  final dropAddress = ''.obs;
  final passengers = 1.obs;
  final pickupDate = Rxn<DateTime>();
  final pickupTimeHour = 12.obs;
  final pickupTimeMinute = 0.obs;
  final pickupAmPm = true.obs; // true = AM
  final flightNumber = ''.obs;
  final airlines = ''.obs;
  final isReturn = false.obs;
  final returnDate = Rxn<DateTime>();
  final returnTimeHour = 12.obs;
  final returnTimeMinute = 0.obs;
  final returnAmPm = true.obs;
  final returnFlightNumber = ''.obs;
  final returnAirlines = ''.obs;

  // Point to Point
  final ptpPickup = ''.obs;
  final ptpDrop = ''.obs;
  final returnPickupAddress = ''.obs;
  final returnDropAddress = ''.obs;

  // Hourly
  final hourlyPickup = ''.obs;
  final hourlyDrop = ''.obs;
  final hourlyHours = 3.obs;

  // ----- Step 2: Select Vehicle -----
  final selectedVehicleId = 0.obs;
  final selectedVehicleName = ''.obs;
  final selectedVehicleBaseCharge = 0.0.obs;
  final selectedVehicleCapacity = 0.obs;
  final selectedVehicleMaxBaggage = 0.obs;
  final distanceMiles = 0.0.obs;
  final costPerMile = 0.0.obs;
  final subtotalFare = 0.0.obs;

  // ----- Step 3: Payment Info / Extras -----
  final firstName = ''.obs;
  final lastName = ''.obs;
  final phone = ''.obs;
  final alternativePhone = ''.obs;
  final email = ''.obs;
  final remark = ''.obs;

  final isMeetAndGreet = false.obs;
  final meetAndGreetCharge = 0.0.obs;
  final isPetInCage = false.obs;
  final petInCageCharge = 0.0.obs;
  final isSnow = false.obs;
  final snowCharge = 0.0.obs;
  final isChildSeat = false.obs;
  final childSeatType = ''.obs; // None, Infant, Toddler
  final childSeatCharge = 0.0.obs;
  final isLateNight = false.obs;
  final lateNightCharge = 0.0.obs;
  final extraBags = 0.obs;
  final extraBagCharge = 0.0.obs;
  final parkingCharge = 10.0.obs;
  final tollCharge = 5.0.obs;

  final offerCode = ''.obs;
  final offerDiscount = 0.0.obs;
  final gratuityPercent = 15.obs; // 15, 20, 25, 30, 35, 40, 45, 50
  final cardProcessingFeePercent = 3.0;
  final cardProcessingFeeAmount = 0.0.obs;
  final totalFare = 0.0.obs;

  final acceptTerms = false.obs;

  /// Combined pickup date-time for display/picker. Null if no date set.
  DateTime? get pickupDateTime {
    final d = pickupDate.value;
    if (d == null) return null;
    final hour24 = pickupAmPm.value
        ? (pickupTimeHour.value == 12 ? 0 : pickupTimeHour.value)
        : (pickupTimeHour.value == 12 ? 12 : pickupTimeHour.value + 12);
    return DateTime(d.year, d.month, d.day, hour24, pickupTimeMinute.value);
  }

  /// Combined return date-time for display/picker.
  DateTime? get returnDateTime {
    final d = returnDate.value;
    if (d == null) return null;
    final hour24 = returnAmPm.value
        ? (returnTimeHour.value == 12 ? 0 : returnTimeHour.value)
        : (returnTimeHour.value == 12 ? 12 : returnTimeHour.value + 12);
    return DateTime(d.year, d.month, d.day, hour24, returnTimeMinute.value);
  }

  /// Set pickup date and time from a single [DateTime].
  void setPickupFromDateTime(DateTime d) {
    pickupDate.value = d;
    pickupTimeHour.value = d.hour == 0
        ? 12
        : (d.hour > 12 ? d.hour - 12 : d.hour);
    pickupTimeMinute.value = d.minute;
    pickupAmPm.value = d.hour < 12;
  }

  /// Set return date and time from a single [DateTime].
  void setReturnFromDateTime(DateTime d) {
    returnDate.value = d;
    returnTimeHour.value = d.hour == 0
        ? 12
        : (d.hour > 12 ? d.hour - 12 : d.hour);
    returnTimeMinute.value = d.minute;
    returnAmPm.value = d.hour < 12;
  }

  /// Reset flow state when starting a new reservation (e.g. from hub).
  void reset() {
    serviceType.value = ReservationServiceType.airport;
    toFromAirport.value = true;
    airportId.value = '';
    airportName.value = '';
    pickupAddress.value = '';
    dropAddress.value = '';
    passengers.value = 1;
    pickupDate.value = null;
    pickupTimeHour.value = 12;
    pickupTimeMinute.value = 0;
    pickupAmPm.value = true;
    flightNumber.value = '';
    airlines.value = '';
    isReturn.value = false;
    returnDate.value = null;
    returnTimeHour.value = 12;
    returnTimeMinute.value = 0;
    returnAmPm.value = true;
    returnFlightNumber.value = '';
    returnAirlines.value = '';
    ptpPickup.value = '';
    ptpDrop.value = '';
    returnPickupAddress.value = '';
    returnDropAddress.value = '';
    hourlyPickup.value = '';
    hourlyDrop.value = '';
    hourlyHours.value = 3;
    selectedVehicleId.value = 0;
    selectedVehicleName.value = '';
    selectedVehicleBaseCharge.value = 0.0;
    selectedVehicleCapacity.value = 0;
    selectedVehicleMaxBaggage.value = 0;
    distanceMiles.value = 0.0;
    costPerMile.value = 0.0;
    subtotalFare.value = 0.0;
    firstName.value = '';
    lastName.value = '';
    phone.value = '';
    alternativePhone.value = '';
    email.value = '';
    remark.value = '';
    isMeetAndGreet.value = false;
    meetAndGreetCharge.value = 0.0;
    isPetInCage.value = false;
    petInCageCharge.value = 0.0;
    isSnow.value = false;
    snowCharge.value = 0.0;
    isChildSeat.value = false;
    childSeatType.value = '';
    childSeatCharge.value = 0.0;
    isLateNight.value = false;
    lateNightCharge.value = 0.0;
    extraBags.value = 0;
    extraBagCharge.value = 0.0;
    parkingCharge.value = 10.0;
    tollCharge.value = 5.0;
    offerCode.value = '';
    offerDiscount.value = 0.0;
    gratuityPercent.value = 15;
    cardProcessingFeeAmount.value = 0.0;
    totalFare.value = 0.0;
    acceptTerms.value = false;
  }

  /// Format pickup time as "10:00 AM" for API.
  String get pickupTimeFormatted {
    var h = pickupTimeHour.value;
    if (!pickupAmPm.value && h != 12) h += 12;
    if (pickupAmPm.value && h == 12) h = 0;
    final m = pickupTimeMinute.value;
    final am = pickupAmPm.value ? 'AM' : 'PM';
    if (h == 0) h = 12;
    return '$h:${m.toString().padLeft(2, '0')} $am';
  }

  /// Pickup date as "yyyy-MM-dd".
  String get pickupDateFormatted => pickupDate.value != null
      ? '${pickupDate.value!.year}-${pickupDate.value!.month.toString().padLeft(2, '0')}-${pickupDate.value!.day.toString().padLeft(2, '0')}'
      : '';

  double get effectiveSubTotal =>
      isReturn.value ? subtotalFare.value * 2 : subtotalFare.value;

  double get subtotalBeforeDiscount =>
      effectiveSubTotal +
      lateNightCharge.value +
      extraBagCharge.value +
      parkingCharge.value +
      tollCharge.value;

  /// Compute gratuity amount from subtotal before gratuity.
  double get gratuityAmount {
    final base = subtotalBeforeDiscount;
    return base * (gratuityPercent.value / 100);
  }

  /// Grand total before card fee.
  double get totalBeforeCardFee =>
      subtotalBeforeDiscount + gratuityAmount - offerDiscount.value;

  /// Recompute total and card fee (call after changing offer/gratuity).
  void recomputeTotals() {
    final beforeCard = totalBeforeCardFee;
    cardProcessingFeeAmount.value =
        beforeCard * (cardProcessingFeePercent / 100);
    totalFare.value = beforeCard + cardProcessingFeeAmount.value;
  }
}
