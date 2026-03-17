import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_texts/privacy_texts.dart';
import 'package:airportshuttle4less/core/widgets/common/app_expansion_tile.dart';

/// Privacy Policy body: sections as [AppExpansionTile]s from privacy-policy.html
/// (Privacy Policy 1–14 and Disclaimer & Limitation of Liability 1–8).
class PrivacyContent extends StatelessWidget {
  const PrivacyContent({super.key});

  static const String _disclaimerIntro =
      'This Disclaimer applies to all users of the services offered by Airport Shuttles 4 Less, including the use of our website, online booking platforms, and transportation services. By using our services, you acknowledge and agree to the terms contained herein.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppExpansionTile(
          title: PrivacyTexts.section1Purpose,
          body: PrivacyTexts.body1Purpose,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section2InfoNotCollected,
          body: PrivacyTexts.body2InfoNotCollected,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section3Financial,
          body: PrivacyTexts.body3Financial,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section4Voluntary,
          body: PrivacyTexts.body4Voluntary,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section5Storage,
          body: PrivacyTexts.body5Storage,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section6Disclosure,
          body: PrivacyTexts.body6Disclosure,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section7Security,
          body: PrivacyTexts.body7Security,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section8Cookies,
          body: PrivacyTexts.body8Cookies,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section9Children,
          body: PrivacyTexts.body9Children,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section10Rights,
          body: PrivacyTexts.body10Rights,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section11Updates,
          body: PrivacyTexts.body11Updates,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section12Sms,
          body: PrivacyTexts.body12Sms,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section13Governing,
          body: PrivacyTexts.body13Governing,
        ),
        AppExpansionTile(
          title: PrivacyTexts.section14Contact,
          body: PrivacyTexts.body14Contact,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimerTitle,
          body: _disclaimerIntro,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer1General,
          body: PrivacyTexts.bodyDisclaimer1,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer2Delays,
          body: PrivacyTexts.bodyDisclaimer2,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer3ThirdParty,
          body: PrivacyTexts.bodyDisclaimer3,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer4Limitation,
          body: PrivacyTexts.bodyDisclaimer4,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer5NoGuarantee,
          body: PrivacyTexts.bodyDisclaimer5,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer6Indemnification,
          body: PrivacyTexts.bodyDisclaimer6,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer7Governing,
          body: PrivacyTexts.bodyDisclaimer7,
        ),
        AppExpansionTile(
          title: PrivacyTexts.disclaimer8Contact,
          body: PrivacyTexts.bodyDisclaimer8,
        ),
      ],
    );
  }
}
