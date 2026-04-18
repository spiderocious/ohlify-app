import 'package:flutter/widgets.dart';

import 'package:ohlify/features/profile/screen/parts/legal_document_screen.dart';

class EulaScreen extends StatelessWidget {
  const EulaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'End user license agreement',
      effectiveLine: 'Effective Date: January 1, 2026',
      sections: [
        LegalDocumentSection(
          heading: '',
          body:
              'This End User License Agreement ("Agreement") is a legal contract between you ("User" or "Licensee") and Ohlify ("Licensor"). Collectively referred to as "Parties". By installing, accessing, or using the software ("Software"), you agree to the terms and conditions set forth in this Agreement. If you do not agree to these terms, do not install or use the Software.',
        ),
        LegalDocumentSection(
          heading: '1. Grant of License',
          body:
              'i. Ohlify grants the User a limited, non-exclusive, non-transferable license to use the Software on a single device.\nii. This license is for personal, non-commercial use unless otherwise agreed in writing.',
        ),
        LegalDocumentSection(
          heading: '2. Restrictions',
          body:
              'You may not:\ni. Copy, modify, or distribute the Software except as expressly permitted by Ohlify.\nii. Reverse-engineer, decompile, or disassemble the Software.\niii. Rent, lease, or sublicense the Software to third parties.',
        ),
      ],
    );
  }
}
