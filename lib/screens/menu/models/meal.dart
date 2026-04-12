class Meal {
  final String id;
  final String name;
  final String emoji;
  final String age; // '6m', '8m', '12m'
  final String category; // 'Purees', 'Finger Foods', 'Breakfast', 'Snacks'
  final int calories;
  final int cookTime;
  final String stage;
  final double rating;
  final int reviews;
  final String imagePath;
  final double price;

  const Meal({
    required this.id,
    required this.name,
    required this.emoji,
    required this.age,
    required this.category,
    required this.calories,
    required this.cookTime,
    required this.stage,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    required this.price,
  });

  int get ageInMonths {
    switch (age) {
      case '6m':
        return 6;
      case '8m':
        return 8;
      case '12m':
        return 12;
      default:
        return 0;
    }
  }
}
