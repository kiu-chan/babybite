import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

// Colors specific to this page
const _kPrimary = Color(0xFF7EB8E8);
const _kSoftBlue = Color(0xFFD4E8F8);
const _kDarkBlue = Color(0xFF2C3E6B);
const _kGreyText = Color(0xFF8DA5C4);

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCCE4F7), Color(0xFFEAF4FF), Color(0xFFF5FAFF)],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildCustomerCard(),
                  const SizedBox(height: 16),
                  _buildCartItemsCard(),
                  const SizedBox(height: 16),
                  _buildSummaryCard(),
                  const SizedBox(height: 20),
                  _buildOrderButton(),
                  const SizedBox(height: 20),
                  _buildAddressCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- HEADER ----------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          const SizedBox(
            width: 44,
            child: Icon(Icons.cloud, color: Colors.white, size: 28),
          ),
          Expanded(
            child: Text(
              'Your Cart',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: _kDarkBlue,
              ),
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: _kPrimary.withValues(alpha: .2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.close_rounded, color: _kPrimary, size: 22),
          ),
        ],
      ),
    );
  }

  // ---------- CUSTOMER INFO ----------
  Widget _buildCustomerCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _kSoftBlue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.face_rounded, color: _kPrimary, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anna Johnson',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _kDarkBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Loyal customer',
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    color: _kGreyText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.blueSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, color: _kPrimary, size: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- CART ITEMS ----------
  Widget _buildCartItemsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildFoodItem(
            emoji: '🥣',
            name: 'Spinach & Potato Puree',
            subtitle: 'Spinach & potato porridge',
            price: '€5.50',
          ),
          const Divider(color: _kSoftBlue, height: 22, thickness: 1),
          _buildFoodItem(
            emoji: '🍲',
            name: 'Mashed Sweet Potato & Carrot',
            subtitle: 'Sweet potato & mashed carrot',
            price: '€5.00',
            timeBadge: '8m',
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem({
    required String emoji,
    required String name,
    required String subtitle,
    required String price,
    String? timeBadge,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _kSoftBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 30))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _kDarkBlue,
                        height: 1.2,
                      ),
                    ),
                  ),
                  if (timeBadge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        timeBadge,
                        style: GoogleFonts.quicksand(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style: GoogleFonts.quicksand(fontSize: 12, color: _kGreyText),
                    ),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _kPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------- SUMMARY ----------
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _summaryRow('Subtotal', '€ 10.50', highlight: true),
          const Divider(color: _kSoftBlue, height: 22, thickness: 1),
          _summaryRow('Delivery fee', '€ 1.50'),
          const Divider(color: _kSoftBlue, height: 22, thickness: 1),
          _summaryRow('Total', '€ 12.00', large: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value,
      {bool highlight = false, bool large = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.quicksand(
            fontSize: large ? 17 : 14,
            fontWeight: large ? FontWeight.w800 : FontWeight.w600,
            color: large ? _kDarkBlue : _kGreyText,
          ),
        ),
        if (highlight)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _kPrimary.withValues(alpha: .15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: _kDarkBlue,
              ),
            ),
          )
        else
          Text(
            value,
            style: GoogleFonts.quicksand(
              fontSize: large ? 18 : 15,
              fontWeight: FontWeight.w800,
              color: _kDarkBlue,
            ),
          ),
      ],
    );
  }

  // ---------- ORDER BUTTON ----------
  Widget _buildOrderButton() {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9BC8EE), Color(0xFF6BA4DB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withValues(alpha: .4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Text(
            'Place Order',
            style: GoogleFonts.quicksand(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- ADDRESS CARD ----------
  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _kSoftBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.home_rounded, color: _kPrimary, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anna Johnson',
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _kDarkBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Bergstraat 32',
                  style: GoogleFonts.quicksand(fontSize: 13, color: _kGreyText),
                ),
                Text(
                  '1000 Brussels',
                  style: GoogleFonts.quicksand(fontSize: 13, color: _kGreyText),
                ),
              ],
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: _kPrimary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit_location_alt_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kPrimary.withValues(alpha: .12),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
