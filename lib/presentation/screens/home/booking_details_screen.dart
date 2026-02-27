import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _flightController = TextEditingController();
  final _specialRequestsController = TextEditingController();
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _flightController.dispose();
    _specialRequestsController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.bookingDetails),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.all(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Passenger Details Section
              Text(
                AppTexts.passengerDetails,
                style: AppTextStyles.heading(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Flight Number
              TextFormField(
                controller: _flightController,
                decoration: InputDecoration(
                  labelText: AppTexts.flightNumber,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Special Requests
              TextFormField(
                controller: _specialRequestsController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppTexts.specialRequests,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Promo Code Section
              Text(
                AppTexts.promoCode,
                style: AppTextStyles.heading(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _promoController,
                      decoration: InputDecoration(
                        labelText: AppTexts.promoCode,
                        border: OutlineInputBorder(borderRadius: borderRadius),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  ElevatedButton(
                    onPressed: () {
                      // Apply promo code logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: AppSpacing.symmetric(context, h: 0.04, v: 0.015),
                    ),
                    child: const Text(AppTexts.applyPromo),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.02),

              // Price Summary
              Container(
                padding: AppSpacing.all(context),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: borderRadius,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(AppTexts.subtotal),
                        const Text('\$75.00'),
                      ],
                    ),
                    AppSpacing.vertical(context, 0.01),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppTexts.discount),
                        Text('-\$0.00'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTexts.totalPrice,
                          style: AppTextStyles.bodyText(context).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$75.00',
                          style: AppTextStyles.bodyText(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Proceed to Payment Button
              SizedBox(
                width: double.infinity,
                height: AppResponsive.scaleSize(context, 50),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.payment);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  ),
                  child: Text(
                    AppTexts.proceedToPayment,
                    style: AppTextStyles.buttonText(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
