import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/constants/faqs_data.dart';
import 'package:airportshuttle4less/core/widgets/features/faqs/faq_expansion_item.dart';
import 'package:airportshuttle4less/core/widgets/features/faqs/faq_section_header.dart';

/// Scrollable FAQs body: section headers and expandable FAQ items.
class FaqsContent extends StatelessWidget {
  const FaqsContent({super.key, this.sections = FaqsData.sections});

  /// FAQ sections to display. Defaults to [FaqsData.sections].
  final List<FaqSection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final section in sections) ...[
          FaqSectionHeader(title: section.title),
          ...section.items.map((item) => FaqExpansionItem(item: item)),
        ],
      ],
    );
  }
}
