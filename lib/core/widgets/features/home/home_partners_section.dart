import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/constants/home_constants.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_section_heading.dart';
import 'package:airportshuttle4less/presentation/controllers/home/home_controller.dart';

class HomePartnersSection extends GetView<HomeController> {
  const HomePartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final partners = HomeConstants.partners;
    final tileHeight = AppResponsive.screenHeight(context) * 0.03;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppSectionHeading(title: AppTexts.homePartnersTitle),
        SizedBox(
          height: tileHeight,
          child: PageView.builder(
            controller: c.partnersPageController,
            onPageChanged: c.onPartnersPageChanged,
            itemCount: partners.length,
            itemBuilder: (context, i) {
              final partner = partners[i];
              return Image.asset(
                partner.imageAsset,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ],
    );
  }
}
