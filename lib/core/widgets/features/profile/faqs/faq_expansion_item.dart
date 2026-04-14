import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/constants/faqs_data.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/widgets/common/app_expansion_tile.dart';

/// Single FAQ item as an expandable tile (question → expanded answer).
/// Uses [AppExpansionTile] with [body] and [contentColor] for answer styling.
class FaqExpansionItem extends StatelessWidget {
  const FaqExpansionItem({super.key, required this.item});

  final FaqItem item;

  @override
  Widget build(BuildContext context) {
    return AppExpansionTile(
      title: item.question,
      body: item.answer,
      contentColor: AppColors.grey,
    );
  }
}
