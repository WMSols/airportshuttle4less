import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/widgets/form/app_text_field/app_text_field.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/edit_profile_controller.dart';

/// Edit profile form: full name and phone (email is not editable).
class ProfileEditForm extends GetView<EditProfileController> {
  const ProfileEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: controller.nameController,
            label: AppTexts.fullName,
            hint: AppTexts.enterFullName,
            prefixIcon: Iconsax.user,
            validator: controller.validateName,
            textInputAction: TextInputAction.next,
          ),
          AppSpacing.vertical(context, 0.02),
          AppTextField(
            controller: controller.phoneController,
            label: AppTexts.phoneNumber,
            hint: AppTexts.enterPhoneNumber,
            prefixIcon: Iconsax.call,
            validator: controller.validatePhone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
