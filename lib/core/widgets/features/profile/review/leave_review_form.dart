import 'package:airportshuttle4less/core/widgets/form/app_datetime_picker/app_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_validators/app_validators.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/core/widgets/form/app_date_display_field/app_date_display_field.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/leave_review_controller.dart';

/// Leave Review form: Name, Message, Email, Phone, Date. Submits via SaveComment.
class LeaveReviewForm extends StatefulWidget {
  const LeaveReviewForm({super.key});

  @override
  State<LeaveReviewForm> createState() => _LeaveReviewFormState();
}

class _LeaveReviewFormState extends State<LeaveReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _prefill();
  }

  Future<void> _prefill() async {
    final controller = Get.find<LeaveReviewController>();
    final prefill = await controller.getPrefill();
    if (!mounted) return;
    if (prefill['name'] != null) _nameController.text = prefill['name']!;
    if (prefill['email'] != null) _emailController.text = prefill['email']!;
    if (prefill['phone'] != null) _phoneController.text = prefill['phone']!;
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String get _dateDisplay => _selectedDate != null
      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
      : '';
  String get _dateApi => _selectedDate != null
      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
      : '';

  Future<void> _openDateTimePicker(
    BuildContext context, {
    required String title,
  }) async {
    final now = DateTime.now();
    final picked = await AppDateTimePicker.show(
      context,
      title: title,
      initial: _selectedDate ?? now,
      minDate: now,
      maxDate: now.add(const Duration(days: 365)),
    );
    if (picked != null && mounted) setState(() => _selectedDate = picked);
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_selectedDate == null) {
      AppToast.showError(AppTexts.error, AppTexts.pleaseFillRequiredFields);
      return;
    }
    final controller = Get.find<LeaveReviewController>();
    await controller.submit(
      name: _nameController.text.trim(),
      message: _messageController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      date: _dateApi,
    );
  }

  @override
  Widget build(BuildContext context) {
    final leaveController = Get.find<LeaveReviewController>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _nameController,
            label: AppTexts.fullName,
            hint: AppTexts.enterFullName,
            prefixIcon: Iconsax.user,
            validator: AppValidators.validateRequiredName,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _messageController,
            label: AppTexts.message,
            hint: AppTexts.enterYourMessageHere,
            prefixIcon: Iconsax.message_question,
            maxLines: 5,
            minLines: 3,
            validator: (v) =>
                AppValidators.validateRequired(v, AppTexts.message),
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _emailController,
            label: AppTexts.email,
            hint: AppTexts.enterEmail,
            prefixIcon: Iconsax.sms,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.validateEmail,
          ),
          AppSpacing.vertical(context, 0.01),
          AppTextField(
            controller: _phoneController,
            label: AppTexts.mobileNumber,
            hint: AppTexts.enterYourMobileNumber,
            prefixIcon: Iconsax.call,
            keyboardType: TextInputType.phone,
            validator: AppValidators.validatePhone,
          ),
          AppSpacing.vertical(context, 0.01),
          AppDateDisplayField(
            label: AppTexts.reviewDate,
            value: _dateDisplay,
            placeholder: AppTexts.datePlaceholder,
            onTap: () =>
                _openDateTimePicker(context, title: AppTexts.selectDate),
            required: true,
          ),
          AppSpacing.vertical(context, 0.02),
          Obx(
            () => AppButton(
              label: AppTexts.submitReview,
              onPressed: leaveController.isSubmitting.value ? null : _onSubmit,
              isLoading: leaveController.isSubmitting.value,
              backgroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
