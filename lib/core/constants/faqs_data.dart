// FAQ content from https://airportshuttles4less.com/faqs.html
// Used for the in-app FAQs screen.

import 'package:airportshuttle4less/core/utils/app_texts/faq_texts.dart';

class FaqItem {
  const FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class FaqSection {
  const FaqSection({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<FaqItem> items;
}

/// All FAQ sections and items (source: airportshuttles4less.com).
class FaqsData {
  FaqsData._();

  static const List<FaqSection> sections = [
    FaqSection(
      id: 'welcome',
      title: FaqTexts.welcomeTitle,
      items: [
        FaqItem(
          question: FaqTexts.welcomeFaq1Question,
          answer: FaqTexts.welcomeFaq1Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq2Question,
          answer: FaqTexts.welcomeFaq2Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq3Question,
          answer: FaqTexts.welcomeFaq3Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq4Question,
          answer: FaqTexts.welcomeFaq4Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq5Question,
          answer: FaqTexts.welcomeFaq5Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq6Question,
          answer: FaqTexts.welcomeFaq6Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq7Question,
          answer: FaqTexts.welcomeFaq7Answer,
        ),
        FaqItem(
          question: FaqTexts.welcomeFaq8Question,
          answer: FaqTexts.welcomeFaq8Answer,
        ),
      ],
    ),
    FaqSection(
      id: 'general',
      title: FaqTexts.generalTitle,
      items: [
        FaqItem(
          question: FaqTexts.generalFaq1Question,
          answer: FaqTexts.generalFaq1Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq2Question,
          answer: FaqTexts.generalFaq2Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq3Question,
          answer: FaqTexts.generalFaq3Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq4Question,
          answer: FaqTexts.generalFaq4Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq5Question,
          answer: FaqTexts.generalFaq5Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq6Question,
          answer: FaqTexts.generalFaq6Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq7Question,
          answer: FaqTexts.generalFaq7Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq8Question,
          answer: FaqTexts.generalFaq8Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq9Question,
          answer: FaqTexts.generalFaq9Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq10Question,
          answer: FaqTexts.generalFaq10Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq11Question,
          answer: FaqTexts.generalFaq11Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq12Question,
          answer: FaqTexts.generalFaq12Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq13Question,
          answer: FaqTexts.generalFaq13Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq14Question,
          answer: FaqTexts.generalFaq14Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq15Question,
          answer: FaqTexts.generalFaq15Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq16Question,
          answer: FaqTexts.generalFaq16Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq17Question,
          answer: FaqTexts.generalFaq17Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq18Question,
          answer: FaqTexts.generalFaq18Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq19Question,
          answer: FaqTexts.generalFaq19Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq20Question,
          answer: FaqTexts.generalFaq20Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq21Question,
          answer: FaqTexts.generalFaq21Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq22Question,
          answer: FaqTexts.generalFaq22Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq23Question,
          answer: FaqTexts.generalFaq23Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq24Question,
          answer: FaqTexts.generalFaq24Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq25Question,
          answer: FaqTexts.generalFaq25Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq26Question,
          answer: FaqTexts.generalFaq26Answer,
        ),
        FaqItem(
          question: FaqTexts.generalFaq27Question,
          answer: FaqTexts.generalFaq27Answer,
        ),
      ],
    ),
    FaqSection(
      id: 'billing',
      title: FaqTexts.billingTitle,
      items: [
        FaqItem(
          question: FaqTexts.billingFaq1Question,
          answer: FaqTexts.billingFaq1Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq2Question,
          answer: FaqTexts.billingFaq2Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq3Question,
          answer: FaqTexts.billingFaq3Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq4Question,
          answer: FaqTexts.billingFaq4Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq5Question,
          answer: FaqTexts.billingFaq5Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq6Question,
          answer: FaqTexts.billingFaq6Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq7Question,
          answer: FaqTexts.billingFaq7Answer,
        ),
        FaqItem(
          question: FaqTexts.billingFaq8Question,
          answer: FaqTexts.billingFaq8Answer,
        ),
      ],
    ),
    FaqSection(
      id: 'booking',
      title: FaqTexts.bookingTitle,
      items: [
        FaqItem(
          question: FaqTexts.bookingFaq1Question,
          answer: FaqTexts.bookingFaq1Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq2Question,
          answer: FaqTexts.bookingFaq2Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq3Question,
          answer: FaqTexts.bookingFaq3Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq4Question,
          answer: FaqTexts.bookingFaq4Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq5Question,
          answer: FaqTexts.bookingFaq5Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq6Question,
          answer: FaqTexts.bookingFaq6Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq7Question,
          answer: FaqTexts.bookingFaq7Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq8Question,
          answer: FaqTexts.bookingFaq8Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq9Question,
          answer: FaqTexts.bookingFaq9Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq10Question,
          answer: FaqTexts.bookingFaq10Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq11Question,
          answer: FaqTexts.bookingFaq11Answer,
        ),
        FaqItem(
          question: FaqTexts.bookingFaq12Question,
          answer: FaqTexts.bookingFaq12Answer,
        ),
      ],
    ),
    FaqSection(
      id: 'extras',
      title: FaqTexts.extrasTitle,
      items: [
        FaqItem(
          question: FaqTexts.extrasFaq1Question,
          answer: FaqTexts.extrasFaq1Answer,
        ),
        FaqItem(
          question: FaqTexts.extrasFaq2Question,
          answer: FaqTexts.extrasFaq2Answer,
        ),
        FaqItem(
          question: FaqTexts.extrasFaq3Question,
          answer: FaqTexts.extrasFaq3Answer,
        ),
      ],
    ),
  ];
}
