import 'package:flutter/material.dart';

import 'package:ohlify/ui/icons/app_icons.dart';
import 'package:ohlify/ui/theme/app_colors.dart';
import 'package:ohlify/ui/widgets/app_text/app_text.dart';

// ── Data model ────────────────────────────────────────────────────────────────

enum _RowType { navigate, toggle, action }

class _MenuRow {
  const _MenuRow.navigate({
    required this.icon,
    required this.label,
    required this.onTap,
  })  : type = _RowType.navigate,
        iconColor = AppColors.textJet,
        labelColor = AppColors.textJet,
        onToggle = null,
        toggleValue = false;

  const _MenuRow.toggle({
    required this.icon,
    required this.label,
    required bool value,
    required ValueChanged<bool> toggle,
  })  : type = _RowType.toggle,
        iconColor = AppColors.textJet,
        labelColor = AppColors.textJet,
        onTap = null,
        toggleValue = value,
        onToggle = toggle;

  const _MenuRow.action({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.textJet,
    this.labelColor = AppColors.textJet,
  })  : type = _RowType.action,
        onToggle = null,
        toggleValue = false;

  final _RowType type;
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final VoidCallback? onTap;
  final bool toggleValue;
  final ValueChanged<bool>? onToggle;
}

// ── Menu group ────────────────────────────────────────────────────────────────

class _MenuGroup extends StatelessWidget {
  const _MenuGroup({required this.title, required this.rows});

  final String title;
  final List<_MenuRow> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          variant: AppTextVariant.label,
          color: AppColors.textMuted,
          align: TextAlign.start,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 8),
        ...rows.map((row) => _RowTile(row: row)),
      ],
    );
  }
}

class _RowTile extends StatelessWidget {
  const _RowTile({required this.row});

  final _MenuRow row;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(row.icon, size: 22, color: row.iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: AppText(
              row.label,
              variant: AppTextVariant.body,
              color: row.labelColor,
              align: TextAlign.start,
              weight: FontWeight.w500,
            ),
          ),
          if (row.type == _RowType.navigate)
            const Icon(AppIcons.chevronRight, size: 20, color: AppColors.textMuted),
          if (row.type == _RowType.toggle)
            Switch(
              value: row.toggleValue,
              onChanged: row.onToggle,
              activeThumbColor: AppColors.background,
              activeTrackColor: AppColors.success,
              inactiveThumbColor: AppColors.background,
              inactiveTrackColor: AppColors.border,
            ),
        ],
      ),
    );

    if (row.type == _RowType.action || row.type == _RowType.navigate) {
      return InkWell(
        onTap: row.onTap,
        child: content,
      );
    }
    return content;
  }
}

// ── Public widget ─────────────────────────────────────────────────────────────

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    super.key,
    required this.onPersonalInfo,
    required this.onRates,
    required this.onBankAccount,
    required this.onChangePassword,
    required this.onNotifications,
    required this.onHelpDesk,
    required this.onPrivacyPolicy,
    required this.onEula,
    required this.onTerms,
    required this.onDeleteAccount,
    required this.onLogout,
  });

  final VoidCallback onPersonalInfo;
  final VoidCallback onRates;
  final VoidCallback onBankAccount;
  final VoidCallback onChangePassword;
  final VoidCallback onNotifications;
  final VoidCallback onHelpDesk;
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onEula;
  final VoidCallback onTerms;
  final VoidCallback onDeleteAccount;
  final VoidCallback onLogout;

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  bool _available = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MenuGroup(
          title: 'Personal',
          rows: [
            _MenuRow.navigate(
              icon: AppIcons.person,
              label: 'Personal information',
              onTap: widget.onPersonalInfo,
            ),
            _MenuRow.navigate(
              icon: AppIcons.star,
              label: 'Rates',
              onTap: widget.onRates,
            ),
            _MenuRow.navigate(
              icon: AppIcons.building,
              label: 'Bank account',
              onTap: widget.onBankAccount,
            ),
            _MenuRow.toggle(
              icon: AppIcons.building,
              label: 'Availability',
              value: _available,
              toggle: (v) => setState(() => _available = v),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _MenuGroup(
          title: 'Others',
          rows: [
            _MenuRow.navigate(
              icon: AppIcons.settings,
              label: 'Change password',
              onTap: widget.onChangePassword,
            ),
            _MenuRow.navigate(
              icon: AppIcons.notification,
              label: 'Notifications',
              onTap: widget.onNotifications,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _MenuGroup(
          title: 'App',
          rows: [
            _MenuRow.action(
              icon: AppIcons.info,
              label: 'Help desk',
              onTap: widget.onHelpDesk,
            ),
            _MenuRow.action(
              icon: AppIcons.info,
              label: 'Privacy policy',
              onTap: widget.onPrivacyPolicy,
            ),
            _MenuRow.action(
              icon: AppIcons.info,
              label: 'End user license agreement',
              onTap: widget.onEula,
            ),
            _MenuRow.action(
              icon: AppIcons.info,
              label: 'Terms & conditions',
              onTap: widget.onTerms,
            ),
            _MenuRow.action(
              icon: AppIcons.logout,
              label: 'Logout',
              onTap: widget.onLogout,
              iconColor: AppColors.danger,
            ),
            _MenuRow.action(
              icon: AppIcons.delete,
              label: 'Delete account',
              onTap: widget.onDeleteAccount,
              iconColor: AppColors.danger,
              labelColor: AppColors.danger,
            ),
          ],
        ),
      ],
    );
  }
}
