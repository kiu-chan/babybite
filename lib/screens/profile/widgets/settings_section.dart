import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (icon: Icons.notifications_none_rounded, label: 'Notifications', hasToggle: true),
      (icon: Icons.lock_outline_rounded, label: 'Privacy & Security', hasToggle: false),
      (icon: Icons.help_outline_rounded, label: 'Help & Support', hasToggle: false),
      (icon: Icons.info_outline_rounded, label: 'About BabyBite', hasToggle: false),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueSoft.withValues(alpha: .18),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: List.generate(items.length, (i) {
            final item = items[i];
            return Column(
              children: [
                _SettingsItem(
                    icon: item.icon,
                    label: item.label,
                    hasToggle: item.hasToggle),
                if (i < items.length - 1)
                  const Divider(
                    height: 1,
                    indent: 56,
                    endIndent: 16,
                    color: AppColors.cardBorder,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _SettingsItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool hasToggle;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.hasToggle,
  });

  @override
  State<_SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<_SettingsItem> {
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: widget.hasToggle ? null : () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EDFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, size: 18, color: AppColors.blueAccent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.label,
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueDeep,
                  ),
                ),
              ),
              if (widget.hasToggle)
                Switch(
                  value: _on,
                  onChanged: (v) => setState(() => _on = v),
                  activeThumbColor: AppColors.blueAccent,
                  activeTrackColor: const Color(0xFFB8DFFB),
                  inactiveThumbColor: AppColors.placeholder,
                  inactiveTrackColor: AppColors.cardBorder,
                )
              else
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.placeholder, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
