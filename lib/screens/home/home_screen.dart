import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../profile/models/user_profile.dart';
import '../profile/models/baby_info.dart';
import 'widgets/hero_header.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/section_head.dart';
import 'widgets/meal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
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
          const SectionHead(),
          const SizedBox(height: 14),
          const HomeMealCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
