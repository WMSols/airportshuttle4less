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
    required this.label,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(AppResponsive.radius(context)),
      child: Row(
        children: [
          SizedBox(
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
          SizedBox(width: AppResponsive.screenWidth(context) * 0.02),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodyText(context).copyWith(
                fontWeight: FontWeight.w500,
                color: value ? AppColors.primary : AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
