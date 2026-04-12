import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';

class FilterDrawer extends StatelessWidget {
  final List<String> ages;
  final int selectedAgeIndex;
  final List<String> categories;
  final int selectedCategoryIndex;
  final ValueChanged<int> onAgeChanged;
  final ValueChanged<int> onCategoryChanged;
  final bool favoritesOnly;
  final ValueChanged<bool> onFavoritesOnlyChanged;
  final VoidCallback onReset;

  const FilterDrawer({
    super.key,
    required this.ages,
    required this.selectedAgeIndex,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onAgeChanged,
    required this.onCategoryChanged,
    required this.favoritesOnly,
    required this.onFavoritesOnlyChanged,
    required this.onReset,
  });

  static const _categoryIcons = [
    (icon: Icons.blur_circular_rounded, color: Color(0xFFF5B638)),
    (icon: Icons.cookie_rounded, color: Color(0xFFF47B89)),
    (icon: Icons.breakfast_dining_rounded, color: Color(0xFF7AC96A)),
    (icon: Icons.icecream_rounded, color: Color(0xFF89B8E3)),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: const Color(0xFFEAF4FF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrawerHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      label: 'Age Group',
                      icon: Icons.wb_sunny_outlined,
                      child: _buildAgeChips(),
                    ),
                    const SizedBox(height: 28),
                    _buildSection(
                      label: 'Category',
                      icon: Icons.restaurant_menu_rounded,
                      child: _buildCategoryChips(),
                    ),
                    const SizedBox(height: 28),
                    _buildSection(
                      label: 'Favorites',
                      icon: Icons.favorite_rounded,
                      child: _buildFavoritesToggle(),
                    ),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.heroTop, AppColors.heroBottom],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.tune_rounded,
              color: AppColors.blueAccent, size: 22),
          const SizedBox(width: 10),
          Text(
            'Filters',
            style: GoogleFonts.fredoka(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.blueDeep,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              onReset();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.blueMid,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: Text(
              'Reset',
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.blueMid,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.blueAccent),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.fredoka(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.blueDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }

  Widget _buildAgeChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(ages.length, (i) {
        final active = i == selectedAgeIndex;
        return GestureDetector(
          onTap: () => onAgeChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            decoration: BoxDecoration(
              color: active ? AppColors.blueAccent : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: active
                    ? AppColors.blueAccent
                    : const Color(0xFFD6E6F7),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueSoft.withValues(alpha: .12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              ages[i],
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: active ? Colors.white : AppColors.blueMid,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(categories.length, (i) {
        final active = i == selectedCategoryIndex;
        return GestureDetector(
          onTap: () => onCategoryChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: active ? AppColors.blueAccent : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: active
                    ? AppColors.blueAccent
                    : const Color(0xFFD6E6F7),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueSoft.withValues(alpha: .12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _categoryIcons[i].icon,
                  size: 16,
                  color: active
                      ? Colors.white
                      : _categoryIcons[i].color,
                ),
                const SizedBox(width: 8),
                Text(
                  categories[i],
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : AppColors.blueDeep,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Text(
            'Apply Filters',
            style: GoogleFonts.quicksand(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD6E6F7)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueSoft.withValues(alpha: .12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile.adaptive(
        value: favoritesOnly,
        onChanged: onFavoritesOnlyChanged,
        activeColor: const Color(0xFFE86868),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          'Only favorites',
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.blueDeep,
          ),
        ),
        secondary: Icon(
          favoritesOnly ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: favoritesOnly ? const Color(0xFFE86868) : AppColors.blueMid,
          size: 18,
        ),
      ),
    );
  }
}
