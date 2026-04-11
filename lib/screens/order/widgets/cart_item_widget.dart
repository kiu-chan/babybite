import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cart_item.dart';

const _kPrimary = Color(0xFF7EB8E8);
const _kSoftBlue = Color(0xFFD4E8F8);
const _kDarkBlue = Color(0xFF2C3E6B);
const _kGreyText = Color(0xFF8DA5C4);

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Center(
            child: Text(item.emoji, style: const TextStyle(fontSize: 30)),
          ),
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
                      item.name,
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _kDarkBlue,
                        height: 1.2,
                      ),
                    ),
                  ),
                  if (item.timeBadge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.timeBadge!,
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
                      item.subtitle,
                      style:
                          GoogleFonts.quicksand(fontSize: 12, color: _kGreyText),
                    ),
                  ),
                  Text(
                    item.priceLabel,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _kPrimary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFECEC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFE57373),
                        size: 18,
                      ),
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
}
