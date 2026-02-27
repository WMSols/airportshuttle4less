import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class CorporateQuoteScreen extends StatefulWidget {
  const CorporateQuoteScreen({super.key});

  @override
  State<CorporateQuoteScreen> createState() => _CorporateQuoteScreenState();
}

class _CorporateQuoteScreenState extends State<CorporateQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _requirementsController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _contactNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corporate Quote'),
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
              Text(
                'Get a Custom Quote for Your Business',
                style: AppTextStyles.heading(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.01),
              Text(
                'Fill out the form below and we will get back to you within 24 hours.',
                style: AppTextStyles.bodyText(context).copyWith(
                  color: AppColors.grey,
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Company Name
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Contact Name
              TextFormField(
                controller: _contactNameController,
                decoration: InputDecoration(
                  labelText: AppTexts.name,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: AppTexts.email,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: AppTexts.phoneNumber,
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Requirements
              TextFormField(
                controller: _requirementsController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Business Requirements',
                  hintText: 'Describe your transportation needs...',
                  border: OutlineInputBorder(borderRadius: borderRadius),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: AppResponsive.scaleSize(context, 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Your request has been submitted. We will contact you soon!',
                        backgroundColor: AppColors.success,
                        colorText: AppColors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                  ),
                  child: Text(
                    'Request Quote',
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
