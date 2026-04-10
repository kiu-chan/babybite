import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import 'menu/meal_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _ageIndex = 0;
  int _categoryIndex = 0;

  final _ages = const ['6m', '8m', '12m', 'All'];
  final _categories = const ['Purees', 'Finger Foods', 'Breakfast', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ColoredBox(
        color: const Color(0xFFEAF4FF),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 18),
              _buildAgeFilter(),
              const SizedBox(height: 14),
              _buildSearchRow(),
              const SizedBox(height: 16),
              _buildCategoryPills(),
              const SizedBox(height: 20),
              _buildMealCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.heroTop, AppColors.heroBottom],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(Icons.arrow_back_rounded, () {}),
          Text(
            'Menu',
            style: GoogleFonts.fredoka(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.blueDeep,
            ),
          ),
          _iconButton(Icons.format_list_bulleted_rounded, () {}),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white.withValues(alpha: .85),
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

  // ============================================================
  // AGE FILTER
  // ============================================================
  Widget _buildAgeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: List.generate(_ages.length, (i) {
          final active = i == _ageIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _ageIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                decoration: BoxDecoration(
                  color: active ? AppColors.blueAccent : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: active ? AppColors.blueAccent : const Color(0xFFD6E6F7),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blueSoft.withValues(alpha: .15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _ages[i],
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : AppColors.blueMid,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // SEARCH + FILTER
  // ============================================================
  Widget _buildSearchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFDBEAF8)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: AppColors.blueAccent, size: 22),
                  const SizedBox(width: 10),
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
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFDBEAF8)),
            ),
            child: Text(
              'Filter',
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.blueMid,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY PILLS
  // ============================================================
  Widget _buildCategoryPills() {
    final icons = [
      (icon: Icons.blur_circular_rounded, color: const Color(0xFFF5B638)),
      (icon: Icons.cookie_rounded, color: const Color(0xFFF47B89)),
      (icon: Icons.breakfast_dining_rounded, color: const Color(0xFF7AC96A)),
      (icon: Icons.icecream_rounded, color: const Color(0xFF89B8E3)),
    ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final active = i == _categoryIndex;
          return GestureDetector(
            onTap: () => setState(() => _categoryIndex = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: active ? AppColors.blueAccent : const Color(0xFFDBEAF8),
                  width: active ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blueSoft.withValues(alpha: .12),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(icons[i].icon, size: 18, color: icons[i].color),
                  const SizedBox(width: 8),
                  Text(
                    _categories[i],
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blueDeep,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // MEAL CARD — bấm vào để vào MealDetailScreen
  // ============================================================
  Widget _buildMealCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MealDetailScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueSoft.withValues(alpha: .2),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.asset(
                'assets/img/menu_card.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
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
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueDeep,
                            height: 1.25,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F0FB),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '8m+',
                          style: GoogleFonts.quicksand(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blueMid,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded,
                          size: 16, color: Color(0xFFF5B638)),
                      const SizedBox(width: 6),
                      Text(
                        '20 min | Stage 2',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7A9BBF),
                        ),
                      ),
                      const Spacer(),
                      ...List.generate(
                        4,
                        (_) => const Icon(Icons.star_rounded,
                            size: 15, color: AppColors.star),
                      ),
                      const Icon(Icons.star_rounded,
                          size: 15, color: Color(0xFFDDE6F0)),
                      const SizedBox(width: 4),
                      Text(
                        '12',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blueMid,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}