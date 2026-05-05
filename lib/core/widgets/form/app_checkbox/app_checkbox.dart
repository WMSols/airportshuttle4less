import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

/// Reusable checkbox widget styled to match AppTextField/AppDropdownField.
/// Use this for form checkboxes like "Return Trip", "Terms & Conditions", etc.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.richLabel,
  }) : assert(
         (label != null) ^ (richLabel != null),
         'Provide exactly one of label or richLabel',
       );

  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Widget? richLabel;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppResponsive.radius(context));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => onChanged(!value),
          borderRadius: radius,
          child: SizedBox(
            width: AppResponsive.iconSize(context),
            height: AppResponsive.iconSize(context),
            child: Checkbox(
              value: value,
              onChanged: (_) => onChanged(!value),
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context) * 0.5,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppResponsive.screenWidth(context) * 0.02),
        Expanded(
          child: richLabel != null
              ? richLabel!
              : InkWell(
                  onTap: () => onChanged(!value),
                  borderRadius: radius,
                  child: Text(
                    label!,
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: value ? AppColors.primary : AppColors.black,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
