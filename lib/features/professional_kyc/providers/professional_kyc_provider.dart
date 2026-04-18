import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_notifier.dart';

class ProfessionalKycProvider extends StatelessWidget {
  const ProfessionalKycProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfessionalKycNotifier>(
      create: (_) => ProfessionalKycNotifier(),
      child: child,
    );
  }
}

extension ProfessionalKycContext on BuildContext {
  ProfessionalKycNotifier get professionalKyc {
    try {
      return read<ProfessionalKycNotifier>();
    } catch (_) {
      throw StateError(
        'professionalKyc accessed outside ProfessionalKycProvider',
      );
    }
  }
}
