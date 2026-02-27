import 'package:flutter/material.dart';

import 'package:airportshuttle4less/core/utils/app_colors/app_colors.dart';
import 'package:airportshuttle4less/core/utils/app_spacing/app_spacing.dart';
import 'package:airportshuttle4less/core/utils/app_styles/app_text_styles.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How do I book a shuttle?',
      'answer':
          'Simply enter your pickup location, drop-off location, date, and time. Then select your vehicle and complete payment.',
    },
    {
      'question': 'What is your cancellation policy?',
      'answer':
          'You can cancel up to 24 hours before your scheduled pickup for a full refund.',
    },
    {
      'question': 'How do I find my driver?',
      'answer':
          'Your driver will contact you 30 minutes before pickup. Look for the vehicle matching your booking details.',
    },
    {
      'question': 'Can I change my booking?',
      'answer':
          'Yes, you can modify your booking up to 12 hours before the scheduled pickup time.',
    },
    {
      'question': 'What payment methods do you accept?',
      'answer': 'We accept all major credit cards, debit cards, and PayPal.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: AppSpacing.all(context),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: AppTextStyles.bodyText(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Padding(
                padding: AppSpacing.all(context),
                child: Text(
                  faq['answer']!,
                  style: AppTextStyles.bodyText(context).copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
