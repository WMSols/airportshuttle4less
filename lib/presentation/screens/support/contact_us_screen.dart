import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.contactUs),
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
              // Contact Info
              Container(
                padding: AppSpacing.all(context),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: borderRadius,
                ),
                child: Column(
                  children: [
                    _buildContactRow(
                      context: context,
                      icon: Icons.phone,
                      text: '+1 (555) 123-4567',
                    ),
                    AppSpacing.vertical(context, 0.015),
                    _buildContactRow(
                      context: context,
                      icon: Icons.email,
                      text: 'support@airportshuttles4less.com',
                    ),
                    AppSpacing.vertical(context, 0.015),
                    _buildContactRow(
                      context: context,
                      icon: Icons.location_on,
                      text: '123 Airport Road, New York, NY 10001',
                    ),
                  ],
                ),
              ),
              AppSpacing.vertical(context, 0.02),

              // Contact Form
              Text(
                AppTexts.getInTouch,
                style: AppTextStyles.heading(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.vertical(context, 0.015),

              // Name
              TextFormField(
                controller: _nameController,
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

              // Message
              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: AppTexts.message,
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
                        'Your message has been sent!',
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
                    AppTexts.submit,
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

  Widget _buildContactRow({
    required BuildContext context,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: AppResponsive.iconSize(context),
        ),
        AppSpacing.horizontal(context, 0.02),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.hintText(context),
          ),
        ),
      ],
    );
  }
}
