class BabyInfo {
  final String name;
  final DateTime? birthDate;
  final String allergies;
  final String weight;

  const BabyInfo({
    required this.name,
    this.birthDate,
    required this.allergies,
    required this.weight,
  });

  /// Tính tuổi từ ngày sinh, trả về chuỗi hiển thị.
  String get age {
    if (birthDate == null) return '—';
    final now = DateTime.now();
    final days = now.difference(birthDate!).inDays;

    if (days < 30) return '$days days old';

    int months = (now.year - birthDate!.year) * 12 +
        (now.month - birthDate!.month);
    if (now.day < birthDate!.day) months--;

    if (months < 24) return '$months months old';

    final years = months ~/ 12;
    final remMonths = months % 12;
    if (remMonths == 0) return '$years years old';
    return '$years years $remMonths months old';
  }

  BabyInfo copyWith({
    String? name,
    DateTime? birthDate,
    bool clearBirthDate = false,
    String? allergies,
    String? weight,
  }) {
    return BabyInfo(
      name: name ?? this.name,
      birthDate: clearBirthDate ? null : (birthDate ?? this.birthDate),
      allergies: allergies ?? this.allergies,
      weight: weight ?? this.weight,
    );
  }
}
