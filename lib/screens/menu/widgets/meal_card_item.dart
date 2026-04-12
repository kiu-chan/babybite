import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../services/favorite_service.dart';
import '../models/meal.dart';
import '../meal_detail_screen.dart';

class MealCardItem extends StatelessWidget {
  final Meal meal;

  const MealCardItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MealDetailScreen(meal: meal),
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
            _buildImage(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final favoriteListenable = FavoriteService.instance.favoriteMealIdsListenable;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Stack(
        children: [
          Image.asset(
            meal.imagePath,
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .9),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                meal.age,
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueMid,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: ValueListenableBuilder<Set<String>>(
              valueListenable: favoriteListenable,
              builder: (_, favoriteIds, __) {
                if (!favoriteIds.contains(meal.id)) {
                  return const SizedBox.shrink();
                }

                return Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .92),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    size: 17,
                    color: Color(0xFFE86868),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal.name,
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blueDeep,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.local_fire_department_rounded,
                  size: 15, color: Color(0xFFF5B638)),
              const SizedBox(width: 5),
              Text(
                '${meal.cookTime} min  •  ${meal.stage}',
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A9BBF),
                ),
              ),
              const Spacer(),
              ...List.generate(
                meal.rating.floor(),
                (_) => const Icon(Icons.star_rounded,
                    size: 14, color: AppColors.star),
              ),
              if (meal.rating % 1 >= 0.5)
                const Icon(Icons.star_half_rounded,
                    size: 14, color: AppColors.star),
              const SizedBox(width: 4),
              Text(
                '${meal.reviews}',
                style: GoogleFonts.quicksand(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueMid,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
