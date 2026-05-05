import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/constants/quote_form_constants.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_sms_consent/app_sms_consent_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/corporate_quote_controller.dart';

class CorporateQuoteContent extends StatelessWidget {
  const CorporateQuoteContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CorporateQuoteController());
    return Form(
      key: controller.formKey,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppTexts.quoteRequestHint,
              style: AppTextStyles.hintText(context).copyWith(
                color: AppColors.black,
                fontSize: AppResponsive.screenWidth(context) * 0.032,
              ),
            ),
            AppSpacing.vertical(context, 0.005),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppTexts.instantPricingPrompt,
                    style: AppTextStyles.hintText(context).copyWith(
                      color: AppColors.black,
                      fontSize: AppResponsive.screenWidth(context) * 0.032,
                    ),
                  ),
                  TextSpan(
                    text: AppTexts.clickHere,
                    style: AppTextStyles.bodyText(context).copyWith(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.primaryFont,
                      fontSize: AppResponsive.screenWidth(context) * 0.032,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.firstNameController,
              label: AppTexts.firstName,
              hint: AppTexts.enterFirstName,
              prefixIcon: Iconsax.user,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.firstName),
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.lastNameController,
              label: AppTexts.lastName,
              hint: AppTexts.enterLastName,
              prefixIcon: Iconsax.user,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.lastName),
            ),
            AppSpacing.vertical(context, 0.01),
            AppDateDisplayField(
              label: AppTexts.pickupDate,
              value: controller.dateDisplay,
              placeholder: AppTexts.datePlaceholder,
              onTap: () => controller.openDateTimePicker(
                context,
                title: AppTexts.selectDate,
              ),
              icon: Iconsax.calendar_1,
            ),
            AppSpacing.vertical(context, 0.01),
            AppDateDisplayField(
              label: AppTexts.pickupTime,
              value: controller.timeDisplay,
              placeholder: AppTexts.timePlaceholder,
              onTap: () => controller.openDateTimePicker(
                context,
                title: AppTexts.selectTime,
              ),
              icon: Iconsax.clock,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.pickUpLocationController,
              label: AppTexts.pickupLocation,
              hint: AppTexts.enterPickupAddress,
              prefixIcon: Iconsax.location,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.pickupLocation),
            ),
            AppSpacing.vertical(context, 0.01),
            AppDropdownField<String>(
              label: AppTexts.typeOfService,
              hint: AppTexts.typeOfService,
              value: controller.serviceType.value,
              items: QuoteFormConstants.serviceTypes,
              prefixIcon: Iconsax.car,
              onChanged: controller.setServiceType,
              getLabel: (v) => v,
              validator: (v) =>
                  v == null || v.isEmpty ? AppTexts.thisFieldIsRequired : null,
            ),
            AppSpacing.vertical(context, 0.01),
            AppDropdownField<String>(
              label: AppTexts.vehicleTypes,
              hint: AppTexts.vehicleTypes,
              value: controller.vehicleType.value,
              items: QuoteFormConstants.vehicleTypes,
              onChanged: controller.setVehicleType,
              getLabel: (v) => v,
              prefixIcon: Iconsax.car,
              validator: (v) =>
                  v == null || v.isEmpty ? AppTexts.thisFieldIsRequired : null,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.hoursController,
              label: AppTexts.hours,
              keyboardType: TextInputType.number,
              hint: AppTexts.enterNumberOfHours,
              prefixIcon: Iconsax.clock,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.hours),
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.passengersController,
              label: AppTexts.passengers,
              keyboardType: TextInputType.number,
              hint: AppTexts.enterNumberOfPassengers,
              prefixIcon: Iconsax.people,
              validator: (v) =>
                  AppValidators.validateRequired(v, AppTexts.passengers),
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.phoneController,
              label: AppTexts.phoneNumber,
              keyboardType: TextInputType.phone,
              prefixIcon: Iconsax.call,
              validator: AppValidators.validatePhone,
              hint: AppTexts.enterPhoneNumber,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.emailController,
              label: AppTexts.email,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Iconsax.sms,
              validator: AppValidators.validateEmail,
              hint: AppTexts.enterEmail,
            ),
            AppSpacing.vertical(context, 0.01),
            AppTextField(
              controller: controller.messageController,
              label: AppTexts.addMessageOptional,
              maxLines: 4,
              hint: AppTexts.enterYourMessageHere,
              prefixIcon: Iconsax.message_question,
            ),
            AppSpacing.vertical(context, 0.02),
            AppSmsConsentCheckbox(
              value: controller.smsConsent.value,
              onChanged: controller.setSmsConsent,
              consentText: AppTexts.smsConsentQuote,
            ),
            AppSpacing.vertical(context, 0.02),
            AppButton(
              label: AppTexts.getYourQuote,
              onPressed: controller.submit,
              isLoading: controller.isSubmitting.value,
              backgroundColor: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
