import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_detail_row.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_flow_controller.dart';

/// Booking details summary for Payment Info step.
class ReservationBookingDetailsSection extends StatelessWidget {
  const ReservationBookingDetailsSection({super.key, required this.flow});

  final ReservationFlowController flow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.serviceLabel,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        AppSpacing.vertical(context, 0.01),
        Text(
          AppTexts.bookingDetailsLabel,
          style: AppTextStyles.bodyText(
            context,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
        AppSpacing.vertical(context, 0.008),
        AppDetailRow(
          icon: Iconsax.location,
          label: AppTexts.pickupLocation,
          value: flow.pickupAddress.value,
        ),
        AppDetailRow(
          icon: Iconsax.location,
          label: AppTexts.dropLocation,
          value: flow.dropAddress.value,
        ),
        AppDetailRow(
          icon: Iconsax.calendar_1,
          label: AppTexts.pickupDateLabel,
          value: flow.pickupDateFormatted,
        ),
        AppDetailRow(
          icon: Iconsax.clock,
          label: AppTexts.pickupTimeLabel,
          value: flow.pickupTimeFormatted,
        ),
        AppDetailRow(
          icon: Iconsax.people,
          label: AppTexts.passengers,
          value: '${flow.passengers.value}',
        ),
        AppDetailRow(
          icon: Iconsax.airplane,
          label: AppTexts.flightNumber,
          value: flow.flightNumber.value.isNotEmpty
              ? flow.flightNumber.value
              : (flow.returnFlightNumber.value.isNotEmpty
                    ? flow.returnFlightNumber.value
                    : '-'),
        ),
        AppDetailRow(
          icon: Iconsax.airplane,
          label: AppTexts.airlinesLabel,
          value: flow.airlines.value.isNotEmpty
              ? flow.airlines.value
              : (flow.returnAirlines.value.isNotEmpty
                    ? flow.returnAirlines.value
                    : '-'),
        ),
      ],
    );
  }
}
