import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_message_banner.dart';

/// Late-night fee note for Payment Info step.
class ReservationNoteBanner extends StatelessWidget {
  const ReservationNoteBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMessageBanner(
      message: AppTexts.lateNightNote,
      type: AppMessageBannerType.warning,
    );
  }
}
