import 'dart:async';
import 'package:flutter/foundation.dart';
import '../screens/order/models/order.dart';
import '../screens/order/models/cart_item.dart';
import '../screens/order/models/delivery_address.dart';
import '../screens/order/models/delivery_time.dart';

class OrderService extends ChangeNotifier {
  static final OrderService instance = OrderService._internal();
  OrderService._internal();

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  List<Order> get activeOrders => _orders
      .where((o) => o.status != OrderStatus.delivered)
      .toList();

  /// Place a new order and start auto-progressing its status.
  Order placeOrder({
    required String orderId,
    required List<CartItem> items,
    required double total,
    required DeliveryAddress address,
    required DeliveryTime deliveryTime,
  }) {
    final order = Order(
      orderId: orderId,
      items: items,
      total: total,
      address: address,
      deliveryTime: deliveryTime,
      createdAt: DateTime.now(),
      status: OrderStatus.received,
    );
    _orders.insert(0, order); // newest first
    notifyListeners();
    _startProgressTimer(orderId);
    return order;
  }

  Order? findById(String orderId) {
    try {
      return _orders.firstWhere((o) => o.orderId == orderId);
    } catch (_) {
      return null;
    }
  }

  void _updateStatus(String orderId, OrderStatus status) {
    final order = findById(orderId);
    if (order == null || order.status == OrderStatus.delivered) return;
    order.status = status;
    notifyListeners();
  }

  /// Simulated progression: Received → Preparing → Out → Delivered
  void _startProgressTimer(String orderId) {
    // → Preparing after 8s
    Timer(const Duration(seconds: 8), () {
      _updateStatus(orderId, OrderStatus.preparing);
      // → Out for delivery after 20s (from start)
      Timer(const Duration(seconds: 12), () {
        _updateStatus(orderId, OrderStatus.outForDelivery);
        // → Delivered after 38s (from start)
        Timer(const Duration(seconds: 18), () {
          _updateStatus(orderId, OrderStatus.delivered);
        });
      });
    });
  }
}
