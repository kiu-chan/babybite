import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _StatCard(
              value: '48',
              label: 'Meals\nTried',
              icon: Icons.restaurant_rounded),
          const SizedBox(width: 12),
          _StatCard(
              value: '12',
              label: 'Saved\nFavorites',
              icon: Icons.favorite_rounded),
          const SizedBox(width: 12),
          _StatCard(
            value: '7',
            label: 'Day\nStreak',
            icon: Icons.local_fire_department_rounded,
            accentColor: const Color(0xFFF5B638),
          ),
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
