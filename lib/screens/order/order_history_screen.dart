import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/order_service.dart';
import 'models/order.dart';
import 'order_tracking_screen.dart';

const _kPrimary = Color(0xFF7EB8E8);
const _kSoftBlue = Color(0xFFD4E8F8);
const _kDarkBlue = Color(0xFF2C3E6B);
const _kGreyText = Color(0xFF8DA5C4);
const _kGreen = Color(0xFF7AC96A);

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    OrderService.instance.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    OrderService.instance.removeListener(_onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderService.instance.orders;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF5FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: orders.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      itemCount: orders.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 12),
                      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: _kPrimary.withValues(alpha: .2),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: _kPrimary, size: 22),
            ),
          ),
          Expanded(
            child: Text(
              'Đơn hàng của tôi',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: _kDarkBlue,
              ),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: _kSoftBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.receipt_long_rounded,
                size: 42, color: _kPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có đơn hàng nào',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: _kDarkBlue,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Hãy đặt món ăn đầu tiên cho bé!',
            style: GoogleFonts.quicksand(fontSize: 13, color: _kGreyText),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────
// ORDER CARD
// ────────────────────────────────────────────────────────
class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final isDelivered = order.status == OrderStatus.delivered;
    final statusColor = isDelivered ? _kGreen : _kPrimary;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withValues(alpha: .12),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: _kSoftBlue,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.receipt_rounded,
                      color: _kPrimary, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order.orderId}',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _kDarkBlue,
                        ),
                      ),
                      Text(
                        order.formattedDate,
                        style: GoogleFonts.quicksand(
                            fontSize: 12, color: _kGreyText),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: order.status),
              ],
            ),
          ),
          // Items preview
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              children: [
                // Stacked images
                SizedBox(
                  height: 36,
                  width: _stackWidth(order.items.length),
                  child: Stack(
                    children: [
                      for (int i = 0;
                          i < order.items.length && i < 3;
                          i++)
                        Positioned(
                          left: i * 22.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              order.items[i].imagePath,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    order.items.length == 1
                        ? order.items.first.name
                        : '${order.items.first.name} +${order.items.length - 1}',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _kGreyText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '€${order.total.toStringAsFixed(2)}',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: _kDarkBlue,
                  ),
                ),
              ],
            ),
          ),
          // Divider + action
          const SizedBox(height: 12),
          const Divider(height: 1, color: _kSoftBlue),
          // Track / View button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20)),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, _) =>
                        OrderTrackingScreen(orderId: order.orderId),
                    transitionsBuilder:
                        (context, animation, _, child) =>
                            SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    ),
                    transitionDuration: const Duration(milliseconds: 350),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isDelivered
                          ? Icons.visibility_rounded
                          : Icons.local_shipping_rounded,
                      color: statusColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isDelivered ? 'Xem chi tiết' : 'Theo dõi đơn hàng',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _stackWidth(int count) {
    final n = count.clamp(1, 3);
    return 36.0 + (n - 1) * 22.0;
  }
}

// ────────────────────────────────────────────────────────
// STATUS BADGE
// ────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isDelivered = status == OrderStatus.delivered;
    final color = isDelivered ? _kGreen : _kPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: GoogleFonts.quicksand(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
