import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/utils/app_responsive/app_responsive.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';
import 'package:airportshuttle4less/domain/entities/vehicle.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({super.key});

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  String? _selectedVehicleId;

  final List<Vehicle> _vehicles = [
    Vehicle(
      id: '1',
      name: 'Standard Sedan',
      type: 'sedan',
      capacity: 3,
      imageUrl: '',
      pricePerPerson: 25.00,
      totalPrice: 75.00,
      amenities: ['AC', 'Wifi'],
      description: 'Up to 3 passengers',
    ),
    Vehicle(
      id: '2',
      name: 'SUV',
      type: 'suv',
      capacity: 6,
      imageUrl: '',
      pricePerPerson: 35.00,
      totalPrice: 210.00,
      amenities: ['AC', 'Wifi', 'Extra Luggage'],
      description: 'Up to 6 passengers',
    ),
    Vehicle(
      id: '3',
      name: 'Van',
      type: 'van',
      capacity: 10,
      imageUrl: '',
      pricePerPerson: 45.00,
      totalPrice: 450.00,
      amenities: ['AC', 'Wifi', 'Entertainment'],
      description: 'Up to 10 passengers',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppResponsive.radius(context));
    final vehicleIconSize = AppResponsive.scaleSize(context, 60);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.selectVehicle),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: AppSpacing.all(context),
              itemCount: _vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _vehicles[index];
                final isSelected = _selectedVehicleId == vehicle.id;

                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.verticalValue(context, 0.015)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedVehicleId = vehicle.id;
                      });
                    },
                    child: Container(
                      padding: AppSpacing.all(context),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.white,
                        borderRadius: borderRadius,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.lightGrey,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Vehicle icon/image placeholder
                          Container(
                            width: vehicleIconSize,
                            height: vehicleIconSize,
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: borderRadius,
                            ),
                            child: Icon(
                              Icons.directions_car,
                              color: AppColors.primary,
                              size: AppResponsive.iconSize(context, factor: 1.5),
                            ),
                          ),
                          AppSpacing.horizontal(context, 0.02),
                          // Vehicle details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicle.name,
                                  style: AppTextStyles.bodyText(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AppSpacing.vertical(context, 0.005),
                                Text(
                                  vehicle.description ?? '',
                                  style: AppTextStyles.hintText(context).copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                                AppSpacing.vertical(context, 0.005),
                                Text(
                                  '\$${vehicle.pricePerPerson.toStringAsFixed(2)}/person',
                                  style: AppTextStyles.hintText(context).copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Selection indicator
                          Radio<String>(
                            value: vehicle.id,
                            groupValue: _selectedVehicleId,
                            onChanged: (value) {
                              setState(() {
                                _selectedVehicleId = value;
                              });
                            },
                            activeColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Continue button
          Padding(
            padding: AppSpacing.all(context),
            child: SizedBox(
              width: double.infinity,
              height: AppResponsive.scaleSize(context, 50),
              child: ElevatedButton(
                onPressed: _selectedVehicleId != null
                    ? () {
                        Get.toNamed(AppRoutes.bookingDetails);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: borderRadius),
                ),
                child: Text(
                  AppTexts.continueBtn,
                  style: AppTextStyles.buttonText(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
