import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_empty_widget.dart';

/// My Bookings screen
class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(
        title: AppTexts.myBookings,
        automaticallyImplyLeading: false,
      ),
      body: AppEmptyWidget(
        message: AppTexts.noBookingsYet,
        imagePath: AppImages.noBookingsYet,
      ),
    );
  }
}
