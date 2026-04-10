import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const _ProfileHeader(),
          const SizedBox(height: 20),
          const _StatsRow(),
          const SizedBox(height: 20),
          const _BabyCard(),
          const SizedBox(height: 20),
          const _SettingsSection(),
          const SizedBox(height: 28),
          const _LogoutButton(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

// ============================================================
// HEADER
// ============================================================
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(36),
        bottomRight: Radius.circular(36),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.heroTop, AppColors.heroBottom],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 44),
                Text(
                  'My Profile',
                  style: GoogleFonts.fredoka(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueDeep,
                    letterSpacing: -0.5,
                  ),
                ),
                _HeaderIconBtn(icon: Icons.edit_rounded, onTap: () {}),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blueSoft.withValues(alpha: .35),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFFD6EDFB),
                    child: Icon(Icons.face_rounded, size: 54, color: AppColors.blueAccent),
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.blueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Anna Johnson',
              style: GoogleFonts.fredoka(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.blueDeep,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'anna.johnson@email.com',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blueMid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: .75),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: AppColors.blueDeep, size: 20),
        ),
      ),
    );
  }
}

// ============================================================
// STATS ROW
// ============================================================
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _StatCard(value: '48', label: 'Meals\nTried', icon: Icons.restaurant_rounded),
          const SizedBox(width: 12),
          _StatCard(value: '12', label: 'Saved\nFavorites', icon: Icons.favorite_rounded),
          const SizedBox(width: 12),
          _StatCard(value: '7', label: 'Day\nStreak', icon: Icons.local_fire_department_rounded, accentColor: const Color(0xFFF5B638)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? accentColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.blueAccent;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueSoft.withValues(alpha: .18),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.fredoka(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.blueDeep,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.placeholder,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BABY INFO CARD
// ============================================================
class _BabyCard extends StatelessWidget {
  const _BabyCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueSoft.withValues(alpha: .2),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6EDFB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.child_care_rounded,
                      size: 20, color: AppColors.blueAccent),
                ),
                const SizedBox(width: 10),
                Text(
                  'Baby Info',
                  style: GoogleFonts.fredoka(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueDeep,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Edit',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(color: AppColors.cardBorder, height: 1),
            const SizedBox(height: 14),
            _BabyInfoRow(icon: Icons.cake_rounded, label: 'Name', value: 'Lily'),
            const SizedBox(height: 10),
            _BabyInfoRow(icon: Icons.today_rounded, label: 'Age', value: '8 months'),
            const SizedBox(height: 10),
            _BabyInfoRow(
              icon: Icons.warning_amber_rounded,
              label: 'Allergies',
              value: 'None',
              valueColor: const Color(0xFF7AC96A),
            ),
            const SizedBox(height: 10),
            _BabyInfoRow(icon: Icons.monitor_weight_outlined, label: 'Weight', value: '8.2 kg'),
          ],
        ),
      ),
    );
  }
}

class _BabyInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _BabyInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.blueSoft),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.placeholder,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.blueDeep,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SETTINGS
// ============================================================
class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    final items = [
      (icon: Icons.notifications_none_rounded, label: 'Notifications', trailing: true),
      (icon: Icons.lock_outline_rounded, label: 'Privacy & Security', trailing: false),
      (icon: Icons.help_outline_rounded, label: 'Help & Support', trailing: false),
      (icon: Icons.info_outline_rounded, label: 'About BabyBite', trailing: false),
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
                  hasToggle: item.trailing,
                ),
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

// ============================================================
// LOGOUT
// ============================================================
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFCCE4F7)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, size: 20, color: AppColors.blueMid),
              const SizedBox(width: 8),
              Text(
                'Log Out',
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueMid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
