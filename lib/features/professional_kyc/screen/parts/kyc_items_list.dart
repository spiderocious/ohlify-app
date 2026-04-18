import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/professional_kyc/providers/professional_kyc_notifier.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/bank_account_modal_content.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/identity_modal_content.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/interests_modal_content.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/kyc_item_tile.dart';
import 'package:ohlify/features/professional_kyc/screen/parts/occupation_modal_content.dart';
import 'package:ohlify/features/professional_kyc/types/identity_details.dart';
import 'package:ohlify/features/professional_kyc/types/kyc_item.dart';
import 'package:ohlify/shared/constants/app_routes.dart';
import 'package:ohlify/shared/helpers/mask_account_number.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';

class KycItemsList extends StatelessWidget {
  const KycItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProfessionalKycNotifier>();

    return Column(
      children: [
        for (int i = 0; i < KycItem.values.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          KycItemTile(
            item: KycItem.values[i],
            completed: notifier.isComplete(KycItem.values[i]),
            summary: _summaryFor(notifier, KycItem.values[i]),
            onTap: () => _openItem(context, notifier, KycItem.values[i]),
          ),
        ],
      ],
    );
  }

  String? _summaryFor(ProfessionalKycNotifier n, KycItem item) {
    return switch (item) {
      KycItem.occupation => n.occupation,
      KycItem.description => n.description,
      KycItem.interests =>
        n.interests.isEmpty ? null : n.interests.join(', '),
      KycItem.bankAccount => n.bankAccount == null
          ? null
          : '${n.bankAccount!.bankName} · ${maskAccountNumber(n.bankAccount!.accountNumber)}',
      KycItem.identity =>
        n.identity == null ? null : '${n.identity!.type.label} verified',
      KycItem.rates => n.rates.isEmpty
          ? null
          : '${n.rates.length} rate${n.rates.length == 1 ? '' : 's'} set',
    };
  }

  void _openItem(
    BuildContext context,
    ProfessionalKycNotifier notifier,
    KycItem item,
  ) {
    switch (item) {
      case KycItem.occupation:
        _openOccupation(notifier);
      case KycItem.description:
        _openDescription(notifier);
      case KycItem.interests:
        _openInterests(notifier);
      case KycItem.bankAccount:
        _openBankAccount(notifier);
      case KycItem.identity:
        _openIdentity(notifier);
      case KycItem.rates:
        context.push(AppRoutes.professionalKycRates);
    }
  }

  void _openOccupation(ProfessionalKycNotifier notifier) {
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Occupation',
      (_, _) => OccupationModalContent(
        initialValue: notifier.occupation,
        onSave: (value) {
          notifier.setOccupation(value);
          handle?.dismiss();
          _toast('Occupation saved');
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );
  }

  void _openDescription(ProfessionalKycNotifier notifier) {
    DrawerService.instance.showInputModal(
      'Description',
      'Set your description, let people know what you do and who you are.',
      options: InputModalOptions(
        placeholder: 'Type your description here...',
        multiline: true,
        maxLength: 500,
        defaultValue: notifier.description,
        confirmButtonText: 'Save',
        showCancelButton: false,
        onConfirm: (value) {
          notifier.setDescription(value.trim());
          _toast('Description saved');
        },
      ),
    );
  }

  void _openInterests(ProfessionalKycNotifier notifier) {
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Interests',
      (_, _) => InterestsModalContent(
        initialInterests: notifier.interests,
        onSave: (values) {
          for (final existing in notifier.interests) {
            if (!values.contains(existing)) {
              notifier.removeInterest(existing);
            }
          }
          for (final v in values) {
            notifier.addInterest(v);
          }
          handle?.dismiss();
          _toast('Interests saved');
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );
  }

  void _openBankAccount(ProfessionalKycNotifier notifier) {
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Add bank account',
      (_, _) => BankAccountModalContent(
        initial: notifier.bankAccount,
        onSave: (details) {
          notifier.setBankAccount(details);
          handle?.dismiss();
          _toast('Bank account saved');
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );
  }

  void _openIdentity(ProfessionalKycNotifier notifier) {
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Identity verification',
      (_, _) => IdentityModalContent(
        initial: notifier.identity,
        onSave: (details) {
          notifier.setIdentity(details);
          handle?.dismiss();
          _toast('Identity submitted');
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );
  }

  void _toast(String message) {
    DrawerService.instance.toast(
      message,
      options: const ToastOptions(type: ToastType.success),
    );
  }
}
