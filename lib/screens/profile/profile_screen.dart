import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/order_service.dart';
import 'models/user_profile.dart';
import 'models/baby_info.dart';
import 'widgets/profile_header.dart';
import 'widgets/stats_row.dart';
import 'widgets/baby_card.dart';
import 'widgets/settings_section.dart';
import 'widgets/logout_button.dart';
import 'edit_profile_screen.dart';
import 'edit_baby_screen.dart';
import '../order/order_history_screen.dart';

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
          _MyOrdersButton(onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const OrderHistoryScreen(),
            ));
          }),
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

// ─────────────────────────────────────────────────────────
// MY ORDERS BUTTON
// ─────────────────────────────────────────────────────────
class _MyOrdersButton extends StatelessWidget {
  final VoidCallback onTap;
  const _MyOrdersButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final activeCount = OrderService.instance.activeOrders.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEAF2FB)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7EB8E8).withValues(alpha: .14),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4E8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.receipt_long_rounded,
                      size: 20, color: Color(0xFF5AA3E8)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'My Orders',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                ),
                if (activeCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5AA3E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$activeCount delivering',
                      style: GoogleFonts.quicksand(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (activeCount == 0)
                  const Icon(Icons.chevron_right_rounded,
                      color: Color(0xFF9EBAD4), size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
