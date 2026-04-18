import 'package:flutter/widgets.dart';

import 'package:ohlify/features/profile/screen/parts/legal_document_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'Privacy Policy',
      effectiveLine: 'Introduction',
      sections: [
        LegalDocumentSection(
          heading: '',
          body:
              'Your privacy is important to us. This Privacy Policy outlines how Ohlify collects, uses, stores, and protects your personal data.',
        ),
        LegalDocumentSection(
          heading: '1. Information We Collect',
          body:
              'i. Personal Information: When you create an account or use the Ohlify software, we may collect personal information such as your name, email address, and payment details.\nii. Usage Data: We collect information about your use of the software, including session duration, clicks, and technical data (IP address, device type).\niii. Cookies: We may use cookies to improve your experience and analyze how our software is used.',
        ),
        LegalDocumentSection(
          heading: '2. How We Use Your Information',
          body:
              'i. To provide, maintain, and improve the Ohlify software.\nii. To personalize your experience and offer recommendations.\niii. To process payments and send you invoices.\niv. To communicate with you about updates, news, and support.\nv. To comply with legal obligations.',
        ),
      ],
    );
  }
}
