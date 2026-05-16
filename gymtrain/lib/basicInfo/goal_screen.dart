import 'package:flutter/material.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  int selectedIndex = 1;

  static const Color kOrange = Color(0xFFFF7A14);

  static const Color kBlack = Color(0xFF0B0B0F);

  final List<Map<String, dynamic>> goals = [
    {"title": "I wanna lose weight", "icon": Icons.monitor_weight_outlined},

    {"title": "I wanna try AI Coach", "icon": Icons.smart_toy_outlined},

    {"title": "I wanna get bulks", "icon": Icons.fitness_center},

    {"title": "I wanna gain endurance", "icon": Icons.monitor_heart_outlined},

    {
      "title": "Just trying out the app! 👍",
      "icon": Icons.phone_iphone_rounded,
    },
  ];

  Widget buildGoalCard(int index) {
    bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        margin: const EdgeInsets.only(bottom: 18),

        padding: const EdgeInsets.symmetric(horizontal: 24),

        height: 110,

        decoration: BoxDecoration(
          color: selected ? kOrange : const Color(0xFFF1F1F1),

          borderRadius: BorderRadius.circular(32),

          border: selected
              ? Border.all(color: const Color(0xFFFFC08B), width: 4)
              : null,
        ),

        child: Row(
          children: [
            Icon(
              goals[index]['icon'],

              color: selected ? Colors.white : const Color(0xFF6B6F7B),

              size: 38,
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                goals[index]['title'],

                style: TextStyle(
                  fontSize: 22,

                  fontWeight: FontWeight.w700,

                  color: selected ? Colors.white : kBlack,
                ),
              ),
            ),

            Container(
              width: 38,
              height: 38,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: selected ? Colors.white : kBlack,

                  width: 2.5,
                ),
              ),

              child: selected
                  ? const Center(
                      child: Icon(Icons.circle, size: 16, color: Colors.white),
                    )
                  : null,
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

              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  // Back
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

                  // Title
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
                      '5 of 5',

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
                "What’s your fitness\ngoal/target?",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,

                  color: kBlack,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 40),

              // Goals
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,

                  itemBuilder: (context, index) {
                    return buildGoalCard(index);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Continue Button
              GestureDetector(
                onTap: () {
                  // FINAL SUBMIT
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
