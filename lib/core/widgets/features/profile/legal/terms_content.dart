import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_texts/terms_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_expansion_tile.dart';

/// Terms & Conditions body: sections as [AppExpansionTile]s built from [TermsTexts].
class TermsContent extends StatelessWidget {
  const TermsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppExpansionTile(
          title: TermsTexts.sectionBookings,
          body: TermsTexts.bookingsBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionCancellations,
          body: TermsTexts.cancellationsBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionDelays,
          body: TermsTexts.delaysBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionChanges,
          body: TermsTexts.changesBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionPayments,
          body: TermsTexts.paymentsBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionAdditionalCharges,
          body: TermsTexts.additionalChargesBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionPickupTime,
          body: TermsTexts.pickupTimeBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionDeposits,
          body: TermsTexts.depositsBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionResolution,
          body: TermsTexts.resolutionBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionVehicleCleaning,
          body: TermsTexts.vehicleCleaningBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionGuestPolicy,
          body: TermsTexts.guestPolicyBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionReservationNotice,
          body: TermsTexts.reservationNoticeBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSupportHours,
          body: TermsTexts.supportHoursBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsTitle,
          body: TermsTexts.sectionSmsBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsConsent,
          body: TermsTexts.smsConsentBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsTypes,
          body: TermsTexts.smsTypesBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsFrequency,
          body: TermsTexts.smsFrequencyBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsFees,
          body: TermsTexts.smsFeesBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsOptIn,
          body: TermsTexts.smsOptInBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsOptOut,
          body: TermsTexts.smsOptOutBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsHelp,
          body: TermsTexts.smsHelpBody,
        ),
        AppExpansionTile(
          title: TermsTexts.sectionSmsDisclosures,
          body: TermsTexts.smsDisclosuresBody,
        ),
      ],
    );
  }
}
