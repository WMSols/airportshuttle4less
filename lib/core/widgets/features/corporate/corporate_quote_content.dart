import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:airportshuttle4less/core/constants/api_constants.dart';
import 'package:airportshuttle4less/core/constants/quote_form_constants.dart';
import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';
import 'package:airportshuttle4less/core/widgets/form/app_dropdown_field/app_dropdown_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_sms_consent/app_sms_consent_checkbox.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';

/// Personalized quote form: first/last name, date, time, locations, service/vehicle type, hours, passengers, contact, optional message, SMS consent, GET YOUR QUOTE.
/// Submits via QuoteMail API.
class CorporateQuoteContent extends StatefulWidget {
  const CorporateQuoteContent({super.key});

  @override
  State<CorporateQuoteContent> createState() => _CorporateQuoteContentState();
}

class _CorporateQuoteContentState extends State<CorporateQuoteContent> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _pickUpLocationController = TextEditingController();
  final _destinationController = TextEditingController();
  final _hoursController = TextEditingController();
  final _passengersController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  /// Single date-time from [AppDateTimePicker]; date and time fields both open the same picker.
  DateTime? _pickUpDateTime;
  String? _serviceType;
  String? _vehicleType;
  bool _smsConsent = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _pickUpLocationController.dispose();
    _destinationController.dispose();
    _hoursController.dispose();
    _passengersController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _openDateTimePicker(
    BuildContext context, {
    required String title,
  }) async {
    final now = DateTime.now();
    final picked = await AppDateTimePicker.show(
      context,
      title: title,
      initial: _pickUpDateTime ?? now,
      minDate: now,
      maxDate: now.add(const Duration(days: 365)),
    );
    if (picked != null && mounted) setState(() => _pickUpDateTime = picked);
  }

  String get _dateDisplay => _pickUpDateTime != null
      ? DateFormat('dd/MM/yyyy').format(_pickUpDateTime!)
      : '';
  String get _timeDisplay => _pickUpDateTime != null
      ? DateFormat('HH:mm').format(_pickUpDateTime!)
      : '';

  String get _dateApi => _pickUpDateTime != null
      ? DateFormat('yyyy-MM-dd').format(_pickUpDateTime!)
      : '';
  String get _timeApi => _pickUpDateTime != null
      ? DateFormat('HH:mm').format(_pickUpDateTime!)
      : '';

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_pickUpDateTime == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    if (_serviceType == null || _serviceType!.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    if (_vehicleType == null || _vehicleType!.isEmpty) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    if (!_smsConsent) {
      AppToast.showError(AppTexts.error, AppTexts.smsConsentRequired);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final useCase = Get.find<SupportUseCase>();
      final success = await useCase.sendQuoteMail(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        pickUpDate: _dateApi,
        pickUpTime: _timeApi,
        pickUpLocation: _pickUpLocationController.text.trim(),
        destination: _destinationController.text.trim(),
        serviceType: _serviceType!,
        vehicleType: _vehicleType!,
        hours: _hoursController.text.trim(),
        passengers: _passengersController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
        currentPageUrl: ApiConstants.baseUrl,
      );
      if (!mounted) return;
      if (success) {
        Get.back();
        AppToast.showSuccess(AppTexts.success, AppTexts.quoteRequestSuccess);
      } else {
        AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
      }
    } catch (_) {
      if (!mounted) return;
      AppToast.showError(AppTexts.error, AppTexts.somethingWentWrong);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
            controller: _firstNameController,
            label: AppTexts.firstName,
            hint: AppTexts.enterFirstName,
            prefixIcon: Iconsax.user,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.firstName),
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _lastNameController,
            label: AppTexts.lastName,
            hint: AppTexts.enterLastName,
            prefixIcon: Iconsax.user,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.lastName),
          ),
          AppSpacing.vertical(context, 0.01),
          AppDateDisplayField(
            label: AppTexts.pickupDate,
            value: _dateDisplay,
            placeholder: AppTexts.datePlaceholder,
            onTap: () =>
                _openDateTimePicker(context, title: AppTexts.selectDate),
            icon: Iconsax.calendar_1,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDateDisplayField(
            label: AppTexts.pickupTime,
            value: _timeDisplay,
            placeholder: AppTexts.timePlaceholder,
            onTap: () =>
                _openDateTimePicker(context, title: AppTexts.selectTime),
            icon: Iconsax.clock,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _pickUpLocationController,
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
            value: _serviceType,
            items: QuoteFormConstants.serviceTypes,
            prefixIcon: Iconsax.car,
            onChanged: (v) => setState(() => _serviceType = v),
            getLabel: (v) => v,
            validator: (v) =>
                v == null || v.isEmpty ? AppTexts.thisFieldIsRequired : null,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDropdownField<String>(
            label: AppTexts.vehicleTypes,
            hint: AppTexts.vehicleTypes,
            value: _vehicleType,
            items: QuoteFormConstants.vehicleTypes,
            onChanged: (v) => setState(() => _vehicleType = v),
            getLabel: (v) => v,
            prefixIcon: Iconsax.car,
            validator: (v) =>
                v == null || v.isEmpty ? AppTexts.thisFieldIsRequired : null,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _hoursController,
            label: AppTexts.hours,
            keyboardType: TextInputType.number,
            hint: AppTexts.enterNumberOfHours,
            prefixIcon: Iconsax.clock,
            validator: (v) => AppValidators.validateRequired(v, AppTexts.hours),
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _passengersController,
            label: AppTexts.passengers,
            keyboardType: TextInputType.number,
            hint: AppTexts.enterNumberOfPassengers,
            prefixIcon: Iconsax.people,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.passengers),
          ),

          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _phoneController,
            label: AppTexts.phoneNumber,
            keyboardType: TextInputType.phone,
            prefixIcon: Iconsax.call,
            validator: AppValidators.validatePhone,
            hint: AppTexts.enterPhoneNumber,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _emailController,
            label: AppTexts.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Iconsax.sms,
            validator: AppValidators.validateEmail,
            hint: AppTexts.enterEmail,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _messageController,
            label: AppTexts.addMessageOptional,
            maxLines: 4,
            hint: AppTexts.enterYourMessageHere,
            prefixIcon: Iconsax.message_question,
          ),
          AppSpacing.vertical(context, 0.02),
          AppSmsConsentCheckbox(
            value: _smsConsent,
            onChanged: (v) => setState(() => _smsConsent = v),
            consentText: AppTexts.smsConsentQuote,
          ),
          AppSpacing.vertical(context, 0.02),
          AppButton(
            label: AppTexts.getYourQuote,
            onPressed: _isSubmitting ? null : _onSubmit,
            isLoading: _isSubmitting,
            backgroundColor: AppColors.black,
          ),
        ],
      ),
    );
  }
}
