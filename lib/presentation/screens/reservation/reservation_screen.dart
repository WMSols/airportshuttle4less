import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_images/app_images.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_custom_app_bar.dart';
import 'package:airportshuttle4less/core/widgets/feedback/app_empty_widget.dart';
import 'package:airportshuttle4less/core/widgets/features/reservation/reservation_step_indicator.dart';
import 'package:airportshuttle4less/presentation/controllers/reservation/reservation_tab_flow_controller.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_payment_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_ride_info_screen.dart';
import 'package:airportshuttle4less/presentation/screens/reservation/reservation_select_vehicle_screen.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabFlow = Get.find<ReservationTabFlowController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppCustomAppBar(
        title: AppTexts.reservation,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => tabFlow.handleRefresh(context),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              ReservationStepIndicator(currentStep: tabFlow.currentStep),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.73,
                child: IndexedStack(
                  index: tabFlow.currentTabIndex.value,
                  children: [
                    const ReservationRideInfoScreen(embedded: true),
                    tabFlow.canShowSelectVehicle
                        ? const ReservationSelectVehicleScreen(embedded: true)
                        : AppEmptyWidget(
                            imagePath: AppImages.noSelectVehicleYet,
                            message: tabFlow.selectVehicleBlockedMessage,
                          ),
                    tabFlow.canShowPaymentInfo
                        ? const ReservationPaymentInfoScreen(embedded: true)
                        : AppEmptyWidget(
                            imagePath: AppImages.noPaymentInfoYet,
                            message: tabFlow.paymentBlockedMessage,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
