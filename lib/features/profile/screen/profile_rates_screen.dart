import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/providers/profile_notifier.dart';
import 'package:ohlify/ui/widgets/rates_list_screen/rates_list_screen.dart';

class ProfileRatesScreen extends StatelessWidget {
  const ProfileRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileNotifier>();
    return RatesListScreen(
      controller: profile,
      submitLabel: 'Done',
    );
  }
}
