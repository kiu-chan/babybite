import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../services/favorite_service.dart';
import 'data/meal_data.dart';
import 'models/meal.dart';
import 'widgets/menu_header.dart';
import 'widgets/meal_card_item.dart';
import 'widgets/filter_drawer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchText = '';

  int _ageIndex = 3; // default: All
  int _categoryIndex = 0;
  bool _favoritesOnly = false;

  static const _ages = ['6m', '8m', '12m', 'All'];
  static const _categories = ['Purees', 'Finger Foods', 'Breakfast', 'Snacks'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _isSearching = false;
        _searchController.clear();
        _searchText = '';
      } else {
        _isSearching = true;
      }
    });
  }

  int get _activeFilterCount {
    int count = 0;
    if (_ageIndex != 3) count++;
    if (_categoryIndex != 0) count++;
    if (_favoritesOnly) count++;
    return count;
  }

  List<Meal> get _filtered {
    final selectedAge = _ages[_ageIndex];
    final selectedCategory = _categories[_categoryIndex];
    final favoriteIds = FavoriteService.instance.favoriteMealIdsListenable.value;

    return allMeals.where((m) {
      final ageOk = selectedAge == 'All' ||
          m.ageInMonths == _ageInMonths(selectedAge);
      final catOk = m.category == selectedCategory;
      final favoriteOk = !_favoritesOnly || favoriteIds.contains(m.id);
      final searchOk = _searchText.isEmpty ||
          m.name.toLowerCase().contains(_searchText.toLowerCase());
      return ageOk && catOk && favoriteOk && searchOk;
    }).toList();
  }

  int _ageInMonths(String age) {
    switch (age) {
      case '6m':
        return 6;
      case '8m':
        return 8;
      case '12m':
        return 12;
      default:
        return 99;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFEAF4FF),
      endDrawer: FilterDrawer(
        ages: _ages,
        selectedAgeIndex: _ageIndex,
        categories: _categories,
        selectedCategoryIndex: _categoryIndex,
        onAgeChanged: (i) => setState(() => _ageIndex = i),
        onCategoryChanged: (i) => setState(() => _categoryIndex = i),
        favoritesOnly: _favoritesOnly,
        onFavoritesOnlyChanged: (value) =>
            setState(() => _favoritesOnly = value),
        onReset: () => setState(() {
          _ageIndex = 3;
          _categoryIndex = 0;
          _favoritesOnly = false;
        }),
      ),
      body: Stack(
        children: [
          // List fills full body, top padding reserves space for floating header
          ValueListenableBuilder<Set<String>>(
            valueListenable: FavoriteService.instance.favoriteMealIdsListenable,
            builder: (_, __, ___) {
              final filteredMeals = _filtered;
              return filteredMeals.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 76, 20, 24),
                      itemCount: filteredMeals.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (_, i) => MealCardItem(meal: filteredMeals[i]),
                    );
            },
          ),

          // Transparent floating header pinned at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MenuHeader(
              isSearching: _isSearching,
              searchController: _searchController,
              onSearchToggle: _toggleSearch,
              onSearchChanged: (v) => setState(() => _searchText = v),
              onFilterTap: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              activeFilterCount: _activeFilterCount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 56, color: AppColors.blueSoft),
          const SizedBox(height: 12),
          Text(
            'No meals found',
            style: GoogleFonts.fredoka(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.blueMid,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different search term',
            style: GoogleFonts.quicksand(
              fontSize: 14,
              color: AppColors.placeholder,
            ),
          ),
        ],
      ),
    );
  }
}
