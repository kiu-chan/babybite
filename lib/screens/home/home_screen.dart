import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../profile/models/user_profile.dart';
import '../profile/models/baby_info.dart';
import '../menu/data/meal_data.dart';
import '../menu/models/meal.dart';
import 'widgets/hero_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/section_head.dart';
import 'widgets/meal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample data — thay bằng state management khi cần đồng bộ với ProfileScreen
  static final _profile = UserProfile(
    name: 'Anna Johnson',
    email: 'anna.johnson@email.com',
    phone: '+32 470 000 000',
  );

  static final _baby = BabyInfo(
    name: 'Lily',
    birthDate: DateTime(2025, 8, 11),
    allergies: 'None',
    weight: '8.2 kg',
  );

  String _selectedAge = '6m+';

  List<Meal> get _recommendedMeals {
    final List<Meal> filtered;
    if (_selectedAge == 'All') {
      filtered = List.of(allMeals);
    } else {
      final targetMonths = _parseAge(_selectedAge);
      filtered =
          allMeals.where((m) => m.ageInMonths == targetMonths).toList();
    }
    // Sort by rating descending, take top 8
    filtered.sort((a, b) => b.rating.compareTo(a.rating));
    return filtered.take(8).toList();
  }

  int _parseAge(String age) {
    switch (age) {
      case '6m+':
        return 6;
      case '8m+':
        return 8;
      case '12m+':
        return 12;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = _recommendedMeals;

    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroHeader(profile: _profile, baby: _baby),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Hi, ${_profile.name.split(' ').first}!',
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
          const HomeSearchBar(),
          const SizedBox(height: 28),
          SectionHead(
            selectedAge: _selectedAge,
            onAgeChanged: (age) => setState(() => _selectedAge = age),
          ),
          const SizedBox(height: 14),
          RecommendedMealsList(meals: meals),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
