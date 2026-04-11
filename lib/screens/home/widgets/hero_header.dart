import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../profile/models/user_profile.dart';
import '../../profile/models/baby_info.dart';

class HeroHeader extends StatelessWidget {
  final UserProfile profile;
  final BabyInfo baby;

  const HeroHeader({
    super.key,
    required this.profile,
    required this.baby,
  });

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ProfileSheet(profile: profile, baby: baby),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _pill(),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Notifications',
                  style: GoogleFonts.fredoka(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueDeep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Icon(Icons.notifications_none_rounded,
                size: 48, color: AppColors.blueSoft),
            const SizedBox(height: 12),
            Text(
              'No new notifications',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.blueMid,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(36),
        bottomRight: Radius.circular(36),
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/img/home_header.png',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IconButton(
                    icon: Icons.menu_rounded,
                    onTap: () => _showMenu(context),
                  ),
                  Text(
                    'BabyBite',
                    style: GoogleFonts.fredoka(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueDeep,
                      letterSpacing: -0.5,
                    ),
                  ),
                  _IconButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: () => _showNotifications(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom sheet ──────────────────────────────────────────────
class _ProfileSheet extends StatelessWidget {
  final UserProfile profile;
  final BabyInfo baby;
  const _ProfileSheet({required this.profile, required this.baby});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
          24, 16, 24, MediaQuery.of(context).padding.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _pill(),
          const SizedBox(height: 20),
          _userSection(context),
          const SizedBox(height: 16),
          const Divider(color: AppColors.cardBorder, height: 1),
          const SizedBox(height: 16),
          _babySection(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _userSection(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFD6EDFB),
            border: Border.all(color: AppColors.cardBorder, width: 2),
          ),
          child: const Icon(Icons.face_rounded,
              size: 34, color: AppColors.blueAccent),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueDeep,
                ),
              ),
              const SizedBox(height: 2),
              _infoLine(Icons.email_outlined, profile.email),
              const SizedBox(height: 2),
              _infoLine(Icons.phone_outlined, profile.phone),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoLine(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.placeholder),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.blueMid,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _babySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F8FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EDFB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.child_care_rounded,
                    size: 18, color: AppColors.blueAccent),
              ),
              const SizedBox(width: 10),
              Text(
                'Baby Info',
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _babyChip(Icons.cake_rounded, baby.name)),
              const SizedBox(width: 8),
              Expanded(child: _babyChip(Icons.today_rounded, baby.age)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _babyChip(
                  Icons.warning_amber_rounded,
                  baby.allergies,
                  valueColor: baby.allergies.toLowerCase() == 'none'
                      ? const Color(0xFF7AC96A)
                      : const Color(0xFFE57373),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: _babyChip(
                      Icons.monitor_weight_outlined, baby.weight)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _babyChip(IconData icon, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.blueSoft),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: valueColor ?? AppColors.blueDeep,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _pill() => Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFDBEAF8),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );

// ── Icon button ───────────────────────────────────────────────
class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});

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
          child: Icon(icon, color: AppColors.blueDeep, size: 22),
        ),
      ),
    );
  }
}
