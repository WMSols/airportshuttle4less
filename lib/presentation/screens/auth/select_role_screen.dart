import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_fonts/app_fonts.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/auth/auth_role.dart';
import 'package:airportshuttle4less/core/widgets/buttons/auth_select_role_button.dart';
import 'package:airportshuttle4less/core/widgets/common/app_auth_footer.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_background.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  void _goToLogin(AuthRole role) {
    Get.toNamed(
      AppRoutes.login,
      arguments: {AuthRoleArgs.roleKey: AuthRoleArgs.routeValue(role)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AppCustomBackground(child: const SizedBox.shrink()),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppSpacing.vertical(context, 0.04),
                        Text(
                          AppTexts.appName,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyText(
                            context,
                          ).copyWith(fontFamily: AppFonts.tertiaryFont),
                        ),
                        AppSpacing.vertical(context, 0.02),
                        Image.asset(
                          AppImages.selectRole,
                          height: AppResponsive.screenHeight(context) * 0.4,
                          fit: BoxFit.contain,
                        ),
                        AppSpacing.vertical(context, 0.02),
                        Text(
                          AppTexts.chooseYourRoleTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyText(context).copyWith(
                            fontFamily: AppFonts.primaryFont,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          AppTexts.chooseYourRoleSubtitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.hintText(
                            context,
                          ).copyWith(fontFamily: AppFonts.secondaryFont),
                        ),
                        AppSpacing.vertical(context, 0.04),
                        SizedBox(
                          height: AppResponsive.screenHeight(context) * 0.12,
                          child: Row(
                            children: [
                              Expanded(
                                child: AuthSelectRoleButton(
                                  imagePath: AppImages.standardUser,
                                  label: AppTexts.standard,
                                  onTap: () =>
                                      _goToLogin(AuthRole.standardUser),
                                ),
                              ),
                              AppSpacing.horizontal(context, 0.06),
                              Expanded(
                                child: AuthSelectRoleButton(
                                  imagePath: AppImages.corporateUser,
                                  label: AppTexts.corporate,
                                  onTap: () => _goToLogin(AuthRole.corporate),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppAuthFooter(
                  promptText: AppTexts.alreadyCorporateUser,
                  linkText: AppTexts.login,
                  onLinkTap: () => _goToLogin(AuthRole.corporate),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
