import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/client_kyc/providers/client_kyc_notifier.dart';

class ClientKycProvider extends StatelessWidget {
  const ClientKycProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClientKycNotifier>(
      create: (_) => ClientKycNotifier(),
      child: child,
    );
  }
}

extension ClientKycContext on BuildContext {
  ClientKycNotifier get clientKyc {
    try {
      return read<ClientKycNotifier>();
    } catch (_) {
      throw StateError('clientKyc accessed outside ClientKycProvider');
    }
  }
}
