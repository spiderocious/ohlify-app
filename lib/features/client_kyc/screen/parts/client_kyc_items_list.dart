import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/client_kyc/providers/client_kyc_notifier.dart';
import 'package:ohlify/features/client_kyc/types/client_kyc_item.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/widgets/interests_form/interests_form.dart';
import 'package:ohlify/ui/widgets/kyc_item_tile/kyc_item_tile.dart';

class ClientKycItemsList extends StatelessWidget {
  const ClientKycItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ClientKycNotifier>();

    return Column(
      children: [
        for (int i = 0; i < ClientKycItem.values.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          KycItemTile(
            icon: _iconFor(ClientKycItem.values[i]),
            title: ClientKycItem.values[i].title,
            subtitle: _summaryFor(notifier, ClientKycItem.values[i]) ??
                ClientKycItem.values[i].subtitle,
            completed: notifier.isComplete(ClientKycItem.values[i]),
            onTap: () => _openItem(notifier, ClientKycItem.values[i]),
          ),
        ],
      ],
    );
  }

  IconData _iconFor(ClientKycItem item) => switch (item) {
        ClientKycItem.fullName => Icons.person_outline_rounded,
        ClientKycItem.interests => Icons.interests_outlined,
        ClientKycItem.description => Icons.article_outlined,
      };

  String? _summaryFor(ClientKycNotifier n, ClientKycItem item) {
    return switch (item) {
      ClientKycItem.fullName => n.fullName,
      ClientKycItem.description => n.description,
      ClientKycItem.interests =>
        n.interests.isEmpty ? null : n.interests.join(', '),
    };
  }

  void _openItem(ClientKycNotifier notifier, ClientKycItem item) {
    switch (item) {
      case ClientKycItem.fullName:
        _openFullName(notifier);
      case ClientKycItem.description:
        _openDescription(notifier);
      case ClientKycItem.interests:
        _openInterests(notifier);
    }
  }

  void _openFullName(ClientKycNotifier notifier) {
    String? pendingValue;
    final handle = DrawerService.instance.showInputModal(
      'Full name',
      'Enter your full legal name as it appears on ID.',
      options: InputModalOptions(
        placeholder: 'e.g. Adedeji Benson Bamidele',
        defaultValue: notifier.fullName,
        confirmButtonText: 'Save',
        showCancelButton: false,
        onConfirm: (value) => pendingValue = value.trim(),
      ),
    );

    handle.onDismissed.then((_) {
      final value = pendingValue;
      if (value == null || value.isEmpty) return;
      notifier.setFullName(value);
      _toast('Full name saved');
    });
  }

  void _openDescription(ClientKycNotifier notifier) {
    String? pendingValue;
    final handle = DrawerService.instance.showInputModal(
      'Description',
      'Set your description, let people know what you do and who you are.',
      options: InputModalOptions(
        placeholder: 'Type your description here...',
        multiline: true,
        maxLength: 500,
        defaultValue: notifier.description,
        confirmButtonText: 'Save',
        showCancelButton: false,
        onConfirm: (value) => pendingValue = value.trim(),
      ),
    );

    handle.onDismissed.then((_) {
      final value = pendingValue;
      if (value == null) return;
      notifier.setDescription(value);
      _toast('Description saved');
    });
  }

  void _openInterests(ClientKycNotifier notifier) {
    List<String>? pendingValues;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Interests',
      (_, _) => InterestsForm(
        initialInterests: notifier.interests,
        onSave: (values) {
          pendingValues = values;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );

    handle.onDismissed.then((_) {
      final values = pendingValues;
      if (values == null) return;
      notifier.setInterests(values);
      _toast('Interests saved');
    });
  }

  void _toast(String message) {
    DrawerService.instance.toast(
      message,
      options: const ToastOptions(type: ToastType.success),
    );
  }
}
