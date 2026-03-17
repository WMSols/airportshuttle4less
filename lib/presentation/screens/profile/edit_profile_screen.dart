import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/buttons/app_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/core/widgets/features/profile/profile_edit_form.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/edit_profile_controller.dart';

/// Edit profile screen: name and phone with save.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    Get.find<EditProfileController>().setTextControllers(
      name: _nameController,
      phone: _phoneController,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();

    return Stack(
      children: [
        Positioned.fill(
          child: AppCustomBackground(
            isMain: true,
            child: const SizedBox.shrink(),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppCustomAppBar(title: AppTexts.editProfile, isBack: true),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      padding: AppSpacing.symmetric(
                        context,
                        h: 0.04,
                        v: 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ProfileEditForm(),
                          AppSpacing.vertical(context, 0.04),
                          Obx(
                            () => AppButton(
                              label: AppTexts.save,
                              onPressed: controller.isSaving.value
                                  ? null
                                  : controller.save,
                              isLoading: controller.isSaving.value,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
