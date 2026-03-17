import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_icon_button.dart';

/// Reusable expansion tile: title in header, expanded content from [body] or [children].
/// Used in FAQs, Terms & Conditions, and Privacy Policy screens.
/// When [body] is set, content is left-aligned text with [AppTextStyles.bodyText] and [contentColor].
/// When [children] is set, those widgets are used as expanded content (no extra alignment wrapper).
class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    super.key,
    required this.title,
    this.body,
    this.children,
    this.initiallyExpanded = false,
    this.backgroundColor,
    this.expandedTitleColor,
    this.collapsedTitleColor,
    this.titleStyle,
    this.contentColor,
    this.contentPadding,
  });

  /// Header text.
  final String title;

  /// Expanded content as a single body string. When set, rendered with [AppTextStyles.bodyText]
  /// and [contentColor], left-aligned. Ignored if null (use [children] instead).
  final String? body;

  /// Expanded content as widgets. Used when [body] is null.
  final List<Widget>? children;

  /// Whether the tile starts expanded.
  final bool initiallyExpanded;

  /// Background color of the tile. Defaults to [AppColors.black].
  final Color? backgroundColor;

  /// Title color when expanded. Defaults to [AppColors.primary].
  final Color? expandedTitleColor;

  /// Title color when collapsed. Defaults to [AppColors.white].
  final Color? collapsedTitleColor;

  /// Optional custom title text style. If null, uses [AppTextStyles.hintText] with color from expanded/collapsed.
  final TextStyle? titleStyle;

  /// Text color for [body] when using string content. Defaults to [AppColors.black]; use e.g. [AppColors.grey] for FAQ.
  final Color? contentColor;

  /// Optional padding for the expanded content. If null, uses default symmetric padding.
  final EdgeInsets? contentPadding;

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(covariant AppExpansionTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      _isExpanded = widget.initiallyExpanded;
    }
  }

  List<Widget> _buildChildren(BuildContext context) {
    if (widget.body != null && widget.body!.isNotEmpty) {
      final color = widget.contentColor ?? AppColors.grey;
      return [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.body!,
            style: AppTextStyles.bodyText(context).copyWith(color: color),
          ),
        ),
      ];
    }
    final c = widget.children;
    return (c != null && c.isNotEmpty) ? c : [const SizedBox.shrink()];
  }

  @override
  Widget build(BuildContext context) {
    final radius = AppResponsive.radius(context);
    final bgColor = widget.backgroundColor ?? AppColors.black;
    final expandedColor = widget.expandedTitleColor ?? AppColors.primary;
    final collapsedColor = widget.collapsedTitleColor ?? AppColors.white;
    final baseTitleStyle =
        widget.titleStyle ??
        AppTextStyles.hintText(context).copyWith(fontWeight: FontWeight.w500);

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.verticalValue(context, 0.01)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: AppColors.primary.withValues(alpha: 0.3),
          highlightColor: AppColors.primary.withValues(alpha: 0.3),
        ),
        child: ExpansionTile(
          initiallyExpanded: widget.initiallyExpanded,
          onExpansionChanged: (expanded) {
            setState(() => _isExpanded = expanded);
          },
          tilePadding: AppSpacing.symmetric(context, h: 0.02, v: 0),
          childrenPadding:
              widget.contentPadding ??
              AppSpacing.symmetric(context, h: 0.02, v: 0.01).copyWith(top: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          iconColor: Colors.transparent,
          collapsedIconColor: Colors.transparent,
          trailing: IgnorePointer(
            child: AppIconButton(
              icon: _isExpanded ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
              color: AppColors.white,
              backgroundColor: AppColors.primary,
            ),
          ),
          title: Text(
            widget.title,
            style: baseTitleStyle.copyWith(
              color: _isExpanded ? expandedColor : collapsedColor,
            ),
          ),
          children: _buildChildren(context),
        ),
      ),
    );
  }
}
