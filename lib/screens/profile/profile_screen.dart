import 'package:flutter/material.dart';
import 'models/user_profile.dart';
import 'models/baby_info.dart';
import 'widgets/profile_header.dart';
import 'widgets/stats_row.dart';
import 'widgets/baby_card.dart';
import 'widgets/settings_section.dart';
import 'widgets/logout_button.dart';
import 'edit_profile_screen.dart';
import 'edit_baby_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile _profile = const UserProfile(
    name: 'Anna Johnson',
    email: 'anna.johnson@email.com',
    phone: '+32 470 000 000',
  );

  BabyInfo _baby = BabyInfo(
    name: 'Lily',
    birthDate: DateTime(2025, 8, 11),
    allergies: 'None',
    weight: '8.2 kg',
  );

  Future<void> _openEditProfile() async {
    final result = await Navigator.of(context).push<UserProfile>(
      MaterialPageRoute(
        builder: (_) => EditProfileScreen(profile: _profile),
      ),
    );
    if (result != null) setState(() => _profile = result);
  }

  Future<void> _openEditBaby() async {
    final result = await Navigator.of(context).push<BabyInfo>(
      MaterialPageRoute(
        builder: (_) => EditBabyScreen(baby: _baby),
      ),
    );
    if (result != null) setState(() => _baby = result);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ProfileHeader(profile: _profile, onEditTap: _openEditProfile),
          const SizedBox(height: 20),
          const StatsRow(),
          const SizedBox(height: 20),
          BabyCard(baby: _baby, onEditTap: _openEditBaby),
          const SizedBox(height: 20),
          const SettingsSection(),
          const SizedBox(height: 28),
          const LogoutButton(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
