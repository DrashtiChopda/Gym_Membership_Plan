import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Constants ───────────────────────────────────────────────────────────────

const kOrange = Color(0xFFFF6B00);
const kDark = Color(0xFF1A1A1A);
const kCardDark = Color(0xFF2A2A2A);
const kBg = Color(0xFFF5F5F5);
const kTextGray = Color(0xFF888888);

// ─── Data Models ─────────────────────────────────────────────────────────────

class Workout {
  final String name;
  final int minutes;
  final int kcal;
  final String imagePath;

  const Workout({
    required this.name,
    required this.minutes,
    required this.kcal,
    required this.imagePath,
  });
}

class Meal {
  final String name;
  final int kcal;
  final int prepMin;
  final int proteinG;
  final int fatsG;
  final String imagePath;

  const Meal({
    required this.name,
    required this.kcal,
    required this.prepMin,
    required this.proteinG,
    required this.fatsG,
    required this.imagePath,
  });
}

final List<Workout> workouts = [
  const Workout(
    name: 'Upper\nStrength',
    minutes: 25,
    kcal: 412,
    imagePath: 'assets/images/upper_strength.jpg',
  ),
  const Workout(
    name: 'Abs',
    minutes: 20,
    kcal: 250,
    imagePath: 'assets/images/abs.jpg',
  ),
  const Workout(
    name: 'Legs',
    minutes: 30,
    kcal: 320,
    imagePath: 'assets/images/legs.jpg',
  ),
  const Workout(
    name: 'Jogging',
    minutes: 30,
    kcal: 280,
    imagePath: 'assets/images/jogging.jpg',
  ),
];

final List<Meal> meals = [
  const Meal(
    name: 'Salad & Egg',
    kcal: 548,
    prepMin: 20,
    proteinG: 25,
    fatsG: 16,
    imagePath: 'assets/images/salad_egg.jpg',
  ),
  const Meal(
    name: 'Salad',
    kcal: 150,
    prepMin: 15,
    proteinG: 20,
    fatsG: 12,
    imagePath: 'assets/images/salad.jpg',
  ),
  const Meal(
    name: 'Fruits Bowl',
    kcal: 120,
    prepMin: 10,
    proteinG: 15,
    fatsG: 8,
    imagePath: 'assets/images/fruits_bowl.jpg',
  ),
  const Meal(
    name: 'Protein Diet',
    kcal: 350,
    prepMin: 25,
    proteinG: 30,
    fatsG: 10,
    imagePath: 'assets/images/protein_diet.jpg',
  ),
];

// ─── Home Screen ─────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNav = 0;
  bool _isNonVeg = true;
  final PageController _workoutPageCtrl = PageController(
    viewportFraction: 0.55,
  );
  final PageController _mealPageCtrl = PageController(viewportFraction: 0.55);
  int _workoutPage = 0;
  int _mealPage = 0;

  @override
  void dispose() {
    _workoutPageCtrl.dispose();
    _mealPageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildSectionHeader('Workouts'),
                    const SizedBox(height: 12),
                    _buildWorkoutCarousel(),
                    const SizedBox(height: 8),
                    _buildDots(_workoutPage, workouts.length),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Diet & Nutrition'),
                    const SizedBox(height: 12),
                    _buildDietFilter(),
                    const SizedBox(height: 12),
                    _buildMealCarousel(),
                    const SizedBox(height: 8),
                    _buildDots(_mealPage, meals.length),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        children: [
          // Top row
          Row(
            children: [
              // Avatar
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade700,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/men.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'May 17, 2026',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          'Hello, ${widget.userName} ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Text('👋', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Text('🔥', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        const Text(
                          '251 kcal',
                          style: TextStyle(
                            color: kOrange,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(width: 1, height: 12, color: Colors.white24),
                        const SizedBox(width: 8),
                        Text(
                          'Goal',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Notification bell
              Stack(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '8+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Section header ────────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kDark,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kOrange,
            ),
          ),
        ],
      ),
    );
  }

  // ── Workout carousel ──────────────────────────────────────────────────────

  Widget _buildWorkoutCarousel() {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _workoutPageCtrl,
        itemCount: workouts.length,
        onPageChanged: (i) => setState(() => _workoutPage = i),
        itemBuilder: (context, i) {
          final w = workouts[i];
          return _WorkoutCard(workout: w);
        },
      ),
    );
  }

  // ── Diet filter ───────────────────────────────────────────────────────────

  Widget _buildDietFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _FilterChip(
            label: 'Non-Veg',
            selected: _isNonVeg,
            onTap: () => setState(() => _isNonVeg = true),
          ),
          const SizedBox(width: 10),
          _FilterChip(
            label: 'Veg',
            selected: !_isNonVeg,
            onTap: () => setState(() => _isNonVeg = false),
          ),
        ],
      ),
    );
  }

  // ── Meal carousel ─────────────────────────────────────────────────────────

  Widget _buildMealCarousel() {
    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: _mealPageCtrl,
        itemCount: meals.length,
        onPageChanged: (i) => setState(() => _mealPage = i),
        itemBuilder: (context, i) {
          final m = meals[i];
          return _MealCard(meal: m);
        },
      ),
    );
  }

  // ── Dots indicator ────────────────────────────────────────────────────────

  Widget _buildDots(int current, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? kOrange : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  // ── Bottom nav ────────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.fitness_center_rounded, 'Workout'),
      (Icons.eco_rounded, 'Diet'),
      (Icons.person_rounded, 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = _selectedNav == i;
              final item = items[i];
              return GestureDetector(
                onTap: () => setState(() => _selectedNav = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? kOrange.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.$1,
                        color: selected ? kOrange : kTextGray,
                        size: 22,
                      ),
                      if (selected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.$2,
                          style: const TextStyle(
                            color: kOrange,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─── Workout Card ─────────────────────────────────────────────────────────────

class _WorkoutCard extends StatelessWidget {
  final Workout workout;
  const _WorkoutCard({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background – gradient placeholder (replace with real NetworkImage)
            _WorkoutPlaceholderImage(name: workout.name),

            // Dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.4, 1.0],
                ),
              ),
            ),

            // Duration badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${workout.minutes} min',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // Name + kcal
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${workout.kcal} kcal',
                        style: const TextStyle(
                          color: kOrange,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('🔥', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Workout placeholder image (gradient) ─────────────────────────────────────

class _WorkoutPlaceholderImage extends StatelessWidget {
  final String name;
  const _WorkoutPlaceholderImage({required this.name});

  static const _colors = [
    [Color(0xFF2C3E50), Color(0xFF4A5568)],
    [Color(0xFF1A1A2E), Color(0xFF16213E)],
    [Color(0xFF0F2027), Color(0xFF203A43)],
    [Color(0xFF2C3E50), Color(0xFF3498DB)],
  ];

  @override
  Widget build(BuildContext context) {
    final idx = name.hashCode.abs() % _colors.length;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _colors[idx],
        ),
      ),
      child: Center(child: Icon(_getIcon(), color: Colors.white24, size: 80)),
    );
  }

  IconData _getIcon() {
    if (name.contains('Strength')) return Icons.fitness_center;
    if (name.contains('Abs')) return Icons.self_improvement;
    if (name.contains('Legs')) return Icons.directions_run;
    if (name.contains('Jogging')) return Icons.directions_run;
    return Icons.fitness_center;
  }
}

// ─── Meal Card ────────────────────────────────────────────────────────────────

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: _MealPlaceholderImage(name: meal.name),
                  ),
                  // Nutrition badges
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      children: [
                        _NutriBadge(
                          label: 'Protein',
                          value: '${meal.proteinG}g',
                        ),
                        const SizedBox(height: 6),
                        _NutriBadge(label: 'Fats', value: '${meal.fatsG}g'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${meal.kcal} kcal',
                        style: const TextStyle(
                          color: kOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${meal.prepMin} min',
                        style: const TextStyle(color: kTextGray, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nutrition Badge ──────────────────────────────────────────────────────────

class _NutriBadge extends StatelessWidget {
  final String label;
  final String value;
  const _NutriBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: kDark,
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 9, color: kTextGray)),
        ],
      ),
    );
  }
}

// ─── Meal placeholder ─────────────────────────────────────────────────────────

class _MealPlaceholderImage extends StatelessWidget {
  final String name;
  const _MealPlaceholderImage({required this.name});

  static const _colors = [
    [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
    [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
  ];

  @override
  Widget build(BuildContext context) {
    final idx = name.hashCode.abs() % _colors.length;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _colors[idx],
        ),
      ),
      child: Center(
        child: Text(_getEmoji(), style: const TextStyle(fontSize: 60)),
      ),
    );
  }

  String _getEmoji() {
    if (name.contains('Egg')) return '🥗';
    if (name.contains('Salad')) return '🥗';
    if (name.contains('Fruit')) return '🍓';
    if (name.contains('Protein')) return '🍗';
    return '🥗';
  }
}

// ─── Filter Chip ──────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? kOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: selected ? kOrange : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : kTextGray,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
