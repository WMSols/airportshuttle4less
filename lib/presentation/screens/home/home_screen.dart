import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_hero_banner.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_locations_section.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_partners_section.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_preffered_vehicles.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_services_grid.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_welcome_section.dart';
import 'package:airportshuttle4less/core/widgets/features/home/home_work_process_grid.dart';

/// Marketing-style home: hero, welcome, services, process grid, locations.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(
        title: AppTexts.homeTitle,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: AppSpacing.symmetric(context, h: 0.04, v: 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const HomeHeroBanner(),
              AppSpacing.vertical(context, 0.02),
              const HomeWelcomeSection(),
              AppSpacing.vertical(context, 0.02),
              const HomePrefferedVehiclesSection(),
              AppSpacing.vertical(context, 0.02),
              const HomeServicesGrid(),
              AppSpacing.vertical(context, 0.01),
              const HomeWorkProcessGrid(),
              AppSpacing.vertical(context, 0.02),
              const HomeLocationsSection(),
              AppSpacing.vertical(context, 0.02),
              const HomePartnersSection(),
            ],
          ),
        ),
      ),
    );
  }
}
