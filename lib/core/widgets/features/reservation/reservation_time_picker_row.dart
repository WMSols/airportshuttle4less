import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';

/// Row of hour, minute, and AM/PM dropdowns for pickup/return time.
class ReservationTimePickerRow extends StatelessWidget {
  const ReservationTimePickerRow({
    super.key,
    required this.hour,
    required this.minute,
    required this.isAm,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onAmPmChanged,
    this.label,
  });

  final int hour;
  final int minute;
  final bool isAm;
  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;
  final ValueChanged<bool> onAmPmChanged;
  final String? label;

  static const List<int> minutes = [0, 10, 20, 30, 40, 50];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.bodyText(context)),
          AppSpacing.vertical(context, 0.008),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<int>(
              value: hour,
              items: List.generate(12, (i) => i + 1)
                  .map((h) => DropdownMenuItem(value: h, child: Text('$h')))
                  .toList(),
              onChanged: (v) => onHourChanged(v ?? 12),
            ),
            AppSpacing.horizontal(context, 0.01),
            DropdownButton<int>(
              value: minute,
              items: minutes
                  .map(
                    (m) => DropdownMenuItem(
                      value: m,
                      child: Text(m.toString().padLeft(2, '0')),
                    ),
                  )
                  .toList(),
              onChanged: (v) => onMinuteChanged(v ?? 0),
            ),
            AppSpacing.horizontal(context, 0.01),
            DropdownButton<bool>(
              value: isAm,
              items: const [
                DropdownMenuItem(value: true, child: Text(AppTexts.periodAm)),
                DropdownMenuItem(value: false, child: Text(AppTexts.periodPm)),
              ],
              onChanged: (v) => onAmPmChanged(v ?? true),
            ),
          ],
        ),
      ],
    );
  }
}
