import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class AppFeatureStripItem {
  const AppFeatureStripItem({required this.icon, required this.text});

  final IconData icon;
  final String text;
}

class AppFeatureStrip extends StatelessWidget {
  const AppFeatureStrip({
    super.key,
    required this.items,
    this.useGrid = false,
    this.crossAxisCount = 2,
    this.maxLines = 1,
    this.iconColor = AppColors.primary,
    this.textColor = AppColors.white,
  });

  final List<AppFeatureStripItem> items;
  final bool useGrid;
  final int crossAxisCount;
  final int maxLines;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppResponsive.radius(context)),
          topRight: Radius.circular(AppResponsive.radius(context)),
        ),
      ),
      padding: AppSpacing.symmetric(context, h: 0.02, v: 0.01),
      child: useGrid ? _buildGrid(context) : _buildRow(context),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 6,
      ),
      itemBuilder: (context, index) => _item(context, items[index]),
    );
  }

  Widget _buildRow(BuildContext context) {
    return Row(
      children: items.map((item) {
        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                color: iconColor,
                size: AppResponsive.iconSize(context, factor: 0.9),
              ),
              AppSpacing.horizontal(context, 0.005),
              Flexible(
                child: Text(
                  item.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.hintText(context).copyWith(
                    color: textColor,
                    height: 0.9,
                    fontWeight: FontWeight.w700,
                    fontSize: AppResponsive.scaleSize(context, 8),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _item(BuildContext context, AppFeatureStripItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: iconColor,
          size: AppResponsive.iconSize(context, factor: 0.85),
        ),
        AppSpacing.horizontal(context, 0.005),
        Expanded(
          child: Text(
            item.text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.hintText(context).copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: AppResponsive.scaleSize(context, 9),
            ),
          ),
        ),
      ],
    );
  }
}
