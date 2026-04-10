import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({super.key});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5FF),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildNutritionDropdown(),
              _buildHeroImage(),
              _buildTodayMealsSection(),
              _buildMealCard(),
              _buildNutritionDetails(),
              _buildActionButtons(),
              _buildOrderSummary(),
              _buildAddressCard(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: [
          _circleBtn(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              'Your Cart',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E3A5F),
              ),
            ),
          ),
          _circleBtn(icon: Icons.settings_rounded, onTap: () {}),
        ],
      ),
    );
  }

  Widget _circleBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF5AA3E8), size: 22),
      ),
    );
  }

  // ============================================================
  // NUTRITION DROPDOWN BANNER
  // ============================================================
  Widget _buildNutritionDropdown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .15),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.favorite_rounded, color: Color(0xFF5AA3E8), size: 20),
            const SizedBox(width: 10),
            Text(
              "Emma's Nutrition",
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E3A5F),
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_up_rounded,
                color: Color(0xFF5AA3E8), size: 22),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HERO IMAGE with decorative elements
  // ============================================================
  Widget _buildHeroImage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 40; // 20 padding each side
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: width,
            height: 210,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/img/cart_header.png',
                    width: width,
                    height: 210,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 14,
                  top: 14,
                  child: _decorativeStar(size: 16, color: Colors.white.withValues(alpha: .7)),
                ),
                Positioned(
                  right: 18,
                  top: 20,
                  child: _decorativeStar(size: 12, color: Colors.white.withValues(alpha: .5)),
                ),
                Positioned(
                  left: 30,
                  bottom: 14,
                  child: _decorativeStar(size: 10, color: Colors.white.withValues(alpha: .5)),
                ),
                Positioned(
                  right: 30,
                  bottom: 18,
                  child: _decorativeStar(size: 14, color: Colors.white.withValues(alpha: .6)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _decorativeStar({required double size, required Color color}) {
    return Icon(Icons.star_rounded, size: size, color: color);
  }

  // ============================================================
  // TODAY'S MEALS SECTION HEADER
  // ============================================================
  Widget _buildTodayMealsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Today's Meals",
            style: GoogleFonts.fredoka(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E3A5F),
            ),
          ),
          Text(
            'Wi, 2m',
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5AA3E8),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MEAL CARD (name + subtitle)
  // ============================================================
  Widget _buildMealCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .12),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('🥑', style: TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Banana & Avocado Mash',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Nutrition',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color(0xFF9EBAD4),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5AA3E8).withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '– 120 Ocalories',
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color(0xFF9EBAD4),
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

  // ============================================================
  // NUTRITION DETAILS
  // ============================================================
  Widget _buildNutritionDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .12),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _nutritionRow('Calorie per 100ml serving', '120 kcal', showArrow: true),
            const SizedBox(height: 12),
            _nutritionRow('Prenatal Carrot...', '', showArrow: true),
            const SizedBox(height: 12),
            _nutritionRow('Vitamin C, Fiber', ''),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Allergens',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9EBAD4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'None',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7AC96A),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7AC96A).withValues(alpha: .2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 12, color: Color(0xFF7AC96A)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _nutritionRow(String label, String value, {bool showArrow = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9EBAD4),
            ),
          ),
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: GoogleFonts.quicksand(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E3A5F),
            ),
          ),
        if (showArrow)
          const Icon(Icons.chevron_right_rounded,
              color: Color(0xFF9EBAD4), size: 20),
      ],
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          // Edit Portion
          Expanded(
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7BB8E8), Color(0xFF5AA3E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5AA3E8).withValues(alpha: .35),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Edit portion',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Add to cart
          Expanded(
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFCCE4F7)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF89B8E3).withValues(alpha: .12),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_rounded,
                      color: Color(0xFF5AA3E8), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Add to cart',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER SUMMARY ROW
  // ============================================================
  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .12),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Quantity control
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TWO',
                  style: GoogleFonts.quicksand(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9EBAD4),
                  ),
                ),
                Text(
                  'Meals',
                  style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E3A5F),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AMOUNT',
                  style: GoogleFonts.quicksand(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF9EBAD4),
                  ),
                ),
                Text(
                  '€ 12',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E3A5F),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Quantity stepper
            Row(
              children: [
                _stepperBtn(
                  icon: Icons.remove,
                  onTap: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '$_quantity',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                ),
                _stepperBtn(
                  icon: Icons.add,
                  onTap: () => setState(() => _quantity++),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepperBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF4FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF5AA3E8)),
      ),
    );
  }

  // ============================================================
  // ADDRESS CARD
  // ============================================================
  Widget _buildAddressCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF89B8E3).withValues(alpha: .12),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFD4E8F8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/img/cart_header.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anna Johnson . Bergstraat 32,',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '1000 Brussels',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: const Color(0xFF9EBAD4),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: Color(0xFF5AA3E8), size: 24),
          ],
        ),
      ),
    );
  }
}