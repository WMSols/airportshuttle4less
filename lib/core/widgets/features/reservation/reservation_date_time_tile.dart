import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';
import 'package:airportshuttle4less/core/widgets/form/app_input_decoration/app_input_decoration.dart';

/// Tappable tile that shows selected date-time or placeholder and opens [AppDateTimePicker].
/// Styled to match AppTextField/AppDropdownField.
class ReservationDateTimeTile extends StatelessWidget {
  const ReservationDateTimeTile({
    super.key,
    this.dateTime,
    required this.onSelected,
    this.label,
    this.showDate = true,
    this.showTime = true,
  });

  final DateTime? dateTime;
  final ValueChanged<DateTime> onSelected;
  final String? label;
  final bool showDate;
  final bool showTime;

  static String _format(DateTime d) {
    final date =
        '${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}-${d.year}';
    var h = d.hour;
    if (h == 0) h = 12;
    if (h > 12) h -= 12;
    final am = d.hour < 12;
    final time =
        '$h:${d.minute.toString().padLeft(2, '0')} ${am ? 'AM' : 'PM'}';
    return '$date $time';
  }

  static String _formatDate(DateTime d) =>
      '${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}-${d.year}';

  static String _formatTime(DateTime d) {
    var h = d.hour;
    if (h == 0) h = 12;
    if (h > 12) h -= 12;
    final am = d.hour < 12;
    return '$h:${d.minute.toString().padLeft(2, '0')} ${am ? 'AM' : 'PM'}';
  }

  @override
  Widget build(BuildContext context) {
    final displayText = dateTime != null
        ? (showDate && showTime
              ? _format(dateTime!)
              : showDate
              ? _formatDate(dateTime!)
              : _formatTime(dateTime!))
        : (showDate && showTime
              ? AppTexts.selectDate
              : showDate
              ? AppTexts.selectDate
              : AppTexts.selectTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              bottom: AppResponsive.screenHeight(context) * 0.005,
            ),
            child: Text(
              label!,
              style: AppTextStyles.bodyText(
                context,
              ).copyWith(fontWeight: FontWeight.w500, color: AppColors.primary),
            ),
          ),
        InkWell(
          onTap: () async {
            final picked = await AppDateTimePicker.show(
              context,
              title: label ?? AppTexts.pickupDateAndTime,
              initial: dateTime ?? DateTime.now(),
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(const Duration(days: 365)),
              showDate: showDate,
              showTime: showTime,
            );
            if (picked != null) onSelected(picked);
          },
          child: InputDecorator(
            decoration: AppInputDecoration.decoration(
              context,
              hintText: displayText,
              prefixIcon: Iconsax.calendar_1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    displayText,
                    style: dateTime != null
                        ? AppTextStyles.bodyText(context)
                        : AppTextStyles.hintText(context),
                  ),
                ),
                Icon(
                  Iconsax.arrow_up_2,
                  size: AppResponsive.iconSize(context),
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
