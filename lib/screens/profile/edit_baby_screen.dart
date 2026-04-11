import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import 'models/baby_info.dart';

class EditBabyScreen extends StatefulWidget {
  final BabyInfo baby;
  const EditBabyScreen({super.key, required this.baby});

  @override
  State<EditBabyScreen> createState() => _EditBabyScreenState();
}

class _EditBabyScreenState extends State<EditBabyScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _allergiesCtrl;
  late final TextEditingController _weightCtrl;
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.baby.name);
    _allergiesCtrl = TextEditingController(text: widget.baby.allergies);
    _weightCtrl = TextEditingController(text: widget.baby.weight);
    _birthDate = widget.baby.birthDate;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _allergiesCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.blueAccent,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.blueDeep,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  /// Định dạng ngày sinh: 11/08/2025
  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  void _save() {
    Navigator.of(context).pop(
      widget.baby.copyWith(
        name: _nameCtrl.text.trim(),
        birthDate: _birthDate,
        clearBirthDate: _birthDate == null,
        allergies: _allergiesCtrl.text.trim(),
        weight: _weightCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('Basic Info'),
                  const SizedBox(height: 12),
                  _buildCard(children: [
                    _field(
                      controller: _nameCtrl,
                      label: "Baby's name",
                      icon: Icons.child_care_rounded,
                    ),
                    _divider(),
                    _birthDateRow(),
                  ]),
                  const SizedBox(height: 20),
                  _sectionLabel('Health'),
                  const SizedBox(height: 12),
                  _buildCard(children: [
                    _field(
                      controller: _allergiesCtrl,
                      label: 'Allergies (e.g. None, Dairy, Eggs)',
                      icon: Icons.warning_amber_rounded,
                    ),
                    _divider(),
                    _field(
                      controller: _weightCtrl,
                      label: 'Weight (e.g. 8.2 kg)',
                      icon: Icons.monitor_weight_outlined,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                    ),
                  ]),
                  const SizedBox(height: 32),
                  _saveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _birthDateRow() {
    final hasDate = _birthDate != null;
    return InkWell(
      onTap: _pickBirthDate,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            const Icon(Icons.cake_rounded,
                size: 20, color: AppColors.blueSoft),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date of birth',
                    style: GoogleFonts.quicksand(
                        fontSize: 13, color: AppColors.placeholder),
                  ),
                  if (hasDate) ...[
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(_birthDate!),
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blueDeep,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (hasDate) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EDFB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  // tính tuổi tạm thời để hiển thị preview
                  BabyInfo(
                    name: '',
                    birthDate: _birthDate,
                    allergies: '',
                    weight: '',
                  ).age,
                  style: GoogleFonts.quicksand(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            const Icon(Icons.calendar_month_outlined,
                size: 20, color: AppColors.placeholder),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.heroTop, AppColors.heroBottom],
          ),
        ),
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 12, 20, 20),
        child: Row(
          children: [
            _iconBtn(Icons.arrow_back_ios_new_rounded,
                () => Navigator.of(context).pop()),
            Expanded(
              child: Text(
                'Edit Baby Info',
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blueDeep,
                ),
              ),
            ),
            _iconBtn(Icons.check_rounded, _save,
                color: AppColors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return Material(
      color: Colors.white.withValues(alpha: .75),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: color ?? AppColors.blueDeep, size: 20),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.fredoka(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.blueDeep,
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueSoft.withValues(alpha: .15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.blueSoft),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.blueDeep,
              ),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.quicksand(
                    fontSize: 13, color: AppColors.placeholder),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(
      height: 1, indent: 48, endIndent: 16, color: AppColors.cardBorder);

  Widget _saveButton() {
    return GestureDetector(
      onTap: _save,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7EC8F0), Color(0xFF4A9FD8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueAccent.withValues(alpha: .35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Save Changes',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
