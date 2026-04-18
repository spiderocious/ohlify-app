import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/providers/profile_notifier.dart';

class ProfileProvider extends StatelessWidget {
  const ProfileProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileNotifier>(
      create: (_) => ProfileNotifier(),
      child: child,
    );
  }
}

extension ProfileContext on BuildContext {
  ProfileNotifier get profile {
    try {
      return read<ProfileNotifier>();
    } catch (_) {
      throw StateError('profile accessed outside ProfileProvider');
    }
  }
}
