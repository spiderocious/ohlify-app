import 'package:flutter/material.dart';

import 'package:ohlify/shared/types/types.dart';
import 'package:ohlify/ui/widgets/professional_rates_list/professional_rates_list.dart';

class RatesModalContent extends StatelessWidget {
  const RatesModalContent({super.key, required this.rates});

  final List<ProfessionalRate> rates;

  @override
  Widget build(BuildContext context) {
    return ProfessionalRatesList(rates: rates);
  }
}
