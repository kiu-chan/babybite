import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroHeader(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Hi, Anna!',
              style: GoogleFonts.fredoka(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.blueDeep,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'What are we eating today?',
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blueMid,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const _SearchBar(),
          const SizedBox(height: 28),
          const _SectionHead(),
          const SizedBox(height: 14),
          const _MealCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ============================================================
// HERO HEADER
// ============================================================
class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

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
                  _IconButton(icon: Icons.menu_rounded, onTap: () {}),
                  Text(
                    'BabyBite',
                    style: GoogleFonts.fredoka(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueDeep,
                      letterSpacing: -0.5,
                    ),
                  ),
                  _IconButton(icon: Icons.notifications_none_rounded, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

// ============================================================
// SEARCH BAR
// ============================================================
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.bgSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDBEAF8)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.blueAccent,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.blueDeep,
              ),
              decoration: InputDecoration(
                hintText: 'Search meals...',
                hintStyle: GoogleFonts.quicksand(
                  color: AppColors.placeholder,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const Icon(
            Icons.mic_none_rounded,
            color: AppColors.blueAccent,
            size: 20,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION HEAD
// ============================================================
class _SectionHead extends StatelessWidget {
  const _SectionHead();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recommended',
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blueDeep,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD6E6F7)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueMid.withValues(alpha: .08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wb_sunny_outlined,
                  size: 13,
                  color: AppColors.blueMid,
                ),
                const SizedBox(width: 6),
                Text(
                  '6m+',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueMid,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: AppColors.blueMid,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MEAL CARD
// ============================================================
class _MealCard extends StatelessWidget {
  const _MealCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueSoft.withValues(alpha: .25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: Container(
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD9ECFB), Color(0xFFECF5FF)],
                ),
              ),
              child: Image.asset(
                'assets/img/home_card.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Mashed Sweet Potato\n& Carrot',
                        style: GoogleFonts.fredoka(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueDeep,
                          height: 1.25,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F0FB),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '8m',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blueMid,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🥕 2 ing • 8oz',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7A9BBF),
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (_) => const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppColors.star,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
