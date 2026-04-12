import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../menu/meal_detail_screen.dart';
import '../../menu/data/meal_data.dart';

class HomeMealCard extends StatelessWidget {
  const HomeMealCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Featured meal: Mashed Sweet Potato & Carrot (id: '3')
    final meal = allMeals.firstWhere(
      (m) => m.id == '3',
      orElse: () => allMeals.first,
    );

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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(22)),
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
                          meal.name,
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
                          meal.age,
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
                        '${meal.calories} kcal  •  ${meal.cookTime} min',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7A9BBF),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          meal.rating.floor(),
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
      ),
    );
  }
}
