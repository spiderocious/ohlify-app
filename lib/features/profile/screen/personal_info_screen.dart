import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ohlify/features/profile/helpers/otp_gate.dart';
import 'package:ohlify/features/profile/providers/profile_notifier.dart';
import 'package:ohlify/features/profile/screen/parts/personal_info_row.dart';
import 'package:ohlify/features/profile/screen/parts/profile_subscreen_scaffold.dart';
import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_button/app_button.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';
import 'package:ohlify/ui/widgets/app_text_input/app_text_input.dart';
import 'package:ohlify/ui/widgets/interests_form/interests_form.dart';
import 'package:ohlify/ui/widgets/occupation_form/occupation_form.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _maskEmail(String email) {
    final idx = email.indexOf('@');
    if (idx <= 1) return email;
    return '${email[0]}***${email.substring(idx)}';
  }

  String _maskPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\s'), '');
    if (digits.length <= 4) return phone;
    return '***${digits.substring(digits.length - 4)}';
  }

  void _toast(String message) {
    DrawerService.instance.toast(
      message,
      options: const ToastOptions(type: ToastType.success),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileNotifier>();
    if (_nameController.text != profile.fullName) {
      _nameController.text = profile.fullName;
    }

    return ProfileSubscreenScaffold(
      title: 'Personal Information',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          AppTextInput(
            label: 'Full Name',
            controller: _nameController,
            bordered: false,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Save',
            expanded: true,
            radius: 100,
            onPressed: () {
              profile.setFullName(_nameController.text.trim());
              _toast('Full name saved');
            },
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(child: Divider(color: AppColors.border)),
              SizedBox(width: 10),
              Icon(
                Icons.shield_outlined,
                size: 14,
                color: AppColors.textMuted,
              ),
              SizedBox(width: 6),
              Flexible(
                child: AppText(
                  'Your name is linked to your Ohlify account',
                  variant: AppTextVariant.bodyNormal,
                  color: AppColors.textMuted,
                  align: TextAlign.center,
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 20),
          PersonalInfoRow(
            icon: Icons.mail_outline_rounded,
            iconColor: const Color(0xFF60A5FA),
            title: 'Edit Email Address',
            subtitle: profile.email,
            onTap: () => _openEditEmail(profile),
          ),
          const SizedBox(height: 12),
          PersonalInfoRow(
            icon: Icons.phone_outlined,
            iconColor: AppColors.textMuted,
            title: 'Edit Phone Number',
            subtitle: profile.phone,
            onTap: () => _openEditPhone(profile),
          ),
          const SizedBox(height: 12),
          PersonalInfoDescriptionRow(
            icon: Icons.article_outlined,
            iconColor: AppColors.textMuted,
            title: 'Edit Description',
            description: profile.description.isEmpty
                ? 'Not set yet'
                : profile.description,
            onTap: () => _openEditDescription(profile),
          ),
          const SizedBox(height: 12),
          PersonalInfoRow(
            icon: Icons.work_outline_rounded,
            iconColor: AppColors.textMuted,
            title: 'Change occupation',
            subtitle: profile.occupation.isEmpty
                ? 'Not set yet'
                : profile.occupation,
            onTap: () => _openEditOccupation(profile),
          ),
          const SizedBox(height: 12),
          PersonalInfoInterestsRow(
            icon: Icons.interests_outlined,
            iconColor: const Color(0xFF0D6F82),
            title: 'Change interests',
            interests: profile.interests,
            onTap: () => _openEditInterests(profile),
          ),
        ],
      ),
    );
  }

  void _openEditEmail(ProfileNotifier profile) {
    String newEmail = profile.email;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Edit email',
      (_, _) => _EditEmailForm(
        initial: profile.email,
        onSubmit: (value) {
          newEmail = value;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );

    handle.onDismissed.then((_) {
      if (newEmail == profile.email) return;
      showOtpGate(
        channelHint:
            'We sent a 6-digit code to ${_maskEmail(profile.email)} to confirm this change.',
        onVerified: () {
          profile.setEmail(newEmail);
          _toast('Email updated');
        },
      );
    });
  }

  void _openEditPhone(ProfileNotifier profile) {
    String newPhone = profile.phone;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Edit phone number',
      (_, _) => _EditPhoneForm(
        initial: profile.phone,
        onSubmit: (value) {
          newPhone = value;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );

    handle.onDismissed.then((_) {
      if (newPhone == profile.phone) return;
      showOtpGate(
        channelHint:
            'We sent a 6-digit code to ${_maskPhone(profile.phone)} to confirm this change.',
        onVerified: () {
          profile.setPhone(newPhone);
          _toast('Phone number updated');
        },
      );
    });
  }

  void _openEditDescription(ProfileNotifier profile) {
    String? pendingValue;
    final handle = DrawerService.instance.showInputModal(
      'Edit description',
      'Set your description, let people know what you do and who you are.',
      options: InputModalOptions(
        placeholder: 'Type your feedback here...',
        multiline: true,
        maxLength: 500,
        defaultValue: profile.description,
        confirmButtonText: 'Save',
        showCancelButton: false,
        onConfirm: (value) => pendingValue = value.trim(),
      ),
    );

    handle.onDismissed.then((_) {
      final value = pendingValue;
      if (value == null) return;
      profile.setDescription(value);
      _toast('Description updated');
    });
  }

  void _openEditOccupation(ProfileNotifier profile) {
    String? pendingValue;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Change occupation',
      (_, _) => OccupationForm(
        initialValue: profile.occupation.isEmpty ? null : profile.occupation,
        onSave: (value) {
          pendingValue = value;
          handle?.dismiss();
        },
      ),
      options: const CustomModalOptions(position: ModalPosition.center),
    );

    handle.onDismissed.then((_) {
      final value = pendingValue;
      if (value == null) return;
      profile.setOccupation(value);
      _toast('Occupation updated');
    });
  }

  void _openEditInterests(ProfileNotifier profile) {
    List<String>? pendingValues;
    DrawerHandle? handle;
    handle = DrawerService.instance.showCustomModal(
      'Change interest',
      (_, _) => InterestsForm(
        initialInterests: profile.interests,
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
      profile.setInterests(values);
      _toast('Interests updated');
    });
  }
}

class _EditEmailForm extends StatefulWidget {
  const _EditEmailForm({required this.initial, required this.onSubmit});

  final String initial;
  final ValueChanged<String> onSubmit;

  @override
  State<_EditEmailForm> createState() => _EditEmailFormState();
}

class _EditEmailFormState extends State<_EditEmailForm> {
  late String _value;

  static final _emailPattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  bool get _isValid => _emailPattern.hasMatch(_value);
  bool get _isChanged => _value != widget.initial;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Change your email address, changes to your email will affect where we send scheduled requests and notifications',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        AppTextInput(
          label: 'Email address',
          value: _value,
          placeholder: 'Adedeji@gmail.com',
          keyboardType: TextInputType.emailAddress,
          onChanged: (v) => setState(() => _value = v),
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
          expanded: true,
          radius: 100,
          isDisabled: !_isValid || !_isChanged,
          onPressed: !_isValid || !_isChanged
              ? null
              : () => widget.onSubmit(_value.trim()),
        ),
      ],
    );
  }
}

class _EditPhoneForm extends StatefulWidget {
  const _EditPhoneForm({required this.initial, required this.onSubmit});

  final String initial;
  final ValueChanged<String> onSubmit;

  @override
  State<_EditPhoneForm> createState() => _EditPhoneFormState();
}

class _EditPhoneFormState extends State<_EditPhoneForm> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initial;
  }

  String get _digits => _value.replaceAll(RegExp(r'\D'), '');
  bool get _isValid => _digits.length >= 10;
  bool get _isChanged => _value != widget.initial;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppText(
          'Change your phone number, changes to your phone number will affect where we send scheduled requests and notifications',
          variant: AppTextVariant.body,
          color: AppColors.textMuted,
          align: TextAlign.start,
        ),
        const SizedBox(height: 16),
        const AppText(
          'Phone number',
          variant: AppTextVariant.bodyNormal,
          color: AppColors.textPrimary,
          weight: FontWeight.w500,
          align: TextAlign.start,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '🇳🇬',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '+234',
                    style: TextStyle(
                      fontFamily: 'MonaSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppTextInput(
                value: _value,
                placeholder: '808 123 4567',
                keyboardType: TextInputType.phone,
                onChanged: (v) => setState(() => _value = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        AppButton(
          label: 'Save',
          expanded: true,
          radius: 100,
          isDisabled: !_isValid || !_isChanged,
          onPressed: !_isValid || !_isChanged
              ? null
              : () => widget.onSubmit(_value.trim()),
        ),
      ],
    );
  }
}
