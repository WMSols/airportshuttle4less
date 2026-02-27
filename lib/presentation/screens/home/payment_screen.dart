import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardholderController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardholderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.payment),
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
              // Payment Method Section
              Text(
                AppTexts.paymentMethod,
                style: AppTextStyles.heading(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Card Number
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppTexts.cardNumber,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Expiry Date and CVV
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: AppTexts.expiryDate,
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(borderRadius: borderRadius),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.horizontal(context, 0.02),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppTexts.cvv,
                        border: OutlineInputBorder(borderRadius: borderRadius),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: borderRadius,
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.vertical(context, 0.015),

              // Cardholder Name
              TextFormField(
                controller: _cardholderController,
                decoration: InputDecoration(
                  labelText: AppTexts.cardholderName,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Total Amount
              Container(
                padding: AppSpacing.all(context),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: borderRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.totalPrice,
                      style: AppTextStyles.heading(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$75.00',
                      style: AppTextStyles.heading(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Pay Now Button
              SizedBox(
                width: double.infinity,
                height: AppResponsive.scaleSize(context, 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.offNamed(AppRoutes.success);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  ),
                  child: Text(
                    AppTexts.payNow,
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
