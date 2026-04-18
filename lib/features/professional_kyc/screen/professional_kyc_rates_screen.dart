import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_notifier.dart';
import 'package:ohlify/ui/widgets/rates_list_screen/rates_list_screen.dart';

class ProfessionalKycRatesScreen extends StatelessWidget {
  const ProfessionalKycRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfessionalKycNotifier>();
    return RatesListScreen(controller: notifier);
  }
}
