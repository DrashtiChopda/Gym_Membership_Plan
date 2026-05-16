import 'package:flutter/material.dart';
import 'goal_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = 'Female';

  static const Color kOrange = Color(0xFFFF7A14);

  static const Color kBlack = Color(0xFF0B0B0F);

  Widget buildGenderCard({
    required String title,
    required String image,
    required bool selected,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        height: 190,

        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),

          borderRadius: BorderRadius.circular(32),

          border: Border.all(
            color: selected ? kOrange : Colors.transparent,

            width: 3,
          ),
        ),

        child: Stack(
          children: [
            // Image
            Positioned(
              right: 0,
              bottom: 0,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),

                child: Image.asset(
                  image,

                  height: 190,
                  width: 230,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Icon(icon, size: 38, color: kBlack),

                      const SizedBox(width: 10),

                      Text(
                        title,

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Container(
                    width: 38,
                    height: 38,

                    decoration: BoxDecoration(
                      border: Border.all(color: kBlack, width: 2),

                      shape: BoxShape.circle,

                      color: selected ? kOrange : Colors.transparent,
                    ),

                    child: selected
                        ? const Icon(Icons.check, color: Colors.white, size: 22)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              const SizedBox(height: 20),

              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: Container(
                      width: 62,
                      height: 62,

                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),

                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,

                        color: Color(0xFF6E717A),
                      ),
                    ),
                  ),

                  // Heading
                  const Text(
                    'Assessment',

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: kBlack,
                    ),
                  ),

                  // Progress
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE7FF),

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Text(
                      '4 of 5',

                      style: TextStyle(
                        color: Color(0xFF2D5BDB),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Question
              const Text(
                "What is your gender?",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: kBlack,
                ),
              ),

              const SizedBox(height: 40),

              // Male Card
              buildGenderCard(
                title: 'Male',

                image: 'assets/images/men.png',

                selected: selectedGender == 'Male',

                icon: Icons.male,

                onTap: () {
                  setState(() {
                    selectedGender = 'Male';
                  });
                },
              ),

              const SizedBox(height: 24),

              // Female Card
              buildGenderCard(
                title: 'Female',

                image: 'assets/images/women.png',

                selected: selectedGender == 'Female',

                icon: Icons.female,

                onTap: () {
                  setState(() {
                    selectedGender = 'Female';
                  });
                },
              ),

              const SizedBox(height: 36),

              // Skip Button
              Container(
                height: 82,

                decoration: BoxDecoration(
                  color: const Color(0xFFF2DFC5),

                  borderRadius: BorderRadius.circular(28),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: const [
                    Text(
                      'Prefer to skip, thanks!',

                      style: TextStyle(
                        color: kOrange,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(width: 14),

                    Icon(Icons.close, color: kOrange, size: 32),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => const GoalScreen()),
                  );
                },

                child: Container(
                  height: 78,

                  decoration: BoxDecoration(
                    color: kBlack,

                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Text(
                        'Continue',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(width: 14),

                      Icon(
                        Icons.arrow_forward_rounded,

                        color: Colors.white,

                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
