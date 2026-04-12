import 'cart_item.dart';
import 'delivery_address.dart';
import 'delivery_time.dart';

enum OrderStatus {
  received,
  preparing,
  outForDelivery,
  delivered,
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.received:
        return 'Đã nhận đơn hàng';
      case OrderStatus.preparing:
        return 'Đang chuẩn bị thức ăn';
      case OrderStatus.outForDelivery:
        return 'Đang đi giao hàng';
      case OrderStatus.delivered:
        return 'Đã giao hàng thành công';
    }
  }

  String get sublabel {
    switch (this) {
      case OrderStatus.received:
        return 'Đơn hàng đã được xác nhận';
      case OrderStatus.preparing:
        return 'Bếp đang chế biến món ăn cho bé';
      case OrderStatus.outForDelivery:
        return 'Shipper đang trên đường đến bạn';
      case OrderStatus.delivered:
        return 'Chúc bé ngon miệng!';
    }
  }

  int get index {
    switch (this) {
      case OrderStatus.received:
        return 0;
      case OrderStatus.preparing:
        return 1;
      case OrderStatus.outForDelivery:
        return 2;
      case OrderStatus.delivered:
        return 3;
    }
  }
}

class Order {
  final String orderId;
  final List<CartItem> items;
  final double total;
  final DeliveryAddress address;
  final DeliveryTime deliveryTime;
  final DateTime createdAt;
  OrderStatus status;

  Order({
    required this.orderId,
    required this.items,
    required this.total,
    required this.address,
    required this.deliveryTime,
    required this.createdAt,
    this.status = OrderStatus.received,
  });

  String get formattedDate {
    final d = createdAt;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}  '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}
