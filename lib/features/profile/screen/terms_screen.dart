import 'package:flutter/widgets.dart';

import 'package:ohlify/features/profile/screen/parts/legal_document_screen.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'Terms & Conditions',
      effectiveLine: 'Effective Date: January 1, 2026',
      sections: [
        LegalDocumentSection(
          heading: '',
          body:
              'These Terms & Conditions ("Terms") govern your use of the Ohlify platform. By creating an account or using any part of the Ohlify platform, you agree to be bound by these Terms. If you do not agree, do not use the platform.',
        ),
        LegalDocumentSection(
          heading: '1. Use of the Platform',
          body:
              'i. You must be at least 18 years old, or the age of majority in your jurisdiction, to use Ohlify.\nii. You are responsible for all activity under your account.\niii. You agree not to use the platform for any unlawful or abusive purposes.',
        ),
        LegalDocumentSection(
          heading: '2. Payments and Payouts',
          body:
              'i. Professionals set their own rates. Clients are charged at booking and professionals are paid after the call completes.\nii. Withdrawals are subject to verification of a valid bank account on file.\niii. Ohlify may withhold funds flagged for suspected fraud or chargeback risk.',
        ),
        LegalDocumentSection(
          heading: '3. Termination',
          body:
              'We may suspend or terminate your account at any time if we reasonably believe you have violated these Terms or applicable law. You may close your account at any time from the Profile screen.',
        ),
      ],
    );
  }
}
