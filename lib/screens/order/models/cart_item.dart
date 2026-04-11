class CartItem {
  final String emoji;
  final String name;
  final String subtitle;
  final double priceValue;
  final String? timeBadge;

  const CartItem({
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.priceValue,
    this.timeBadge,
  });

  String get priceLabel => '€${priceValue.toStringAsFixed(2)}';
}
