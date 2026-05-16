import 'package:flutter/material.dart';
import 'weight_screen.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  int selectedAge = 19;

  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 18);

  static const Color kOrange = Color(0xFFFF7A14);

  static const Color kBlack = Color(0xFF0B0B0F);

  Widget buildAgeItem(int age) {
    bool isSelected = age == selectedAge;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      width: isSelected ? 150 : 120,
      height: isSelected ? 150 : 120,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: isSelected ? kOrange : Colors.transparent,

        borderRadius: BorderRadius.circular(isSelected ? 30 : 0),
      ),

      child: Text(
        age.toString(),

        style: TextStyle(
          fontSize: isSelected ? 96 : 74,

          fontWeight: FontWeight.w500,

          color: isSelected ? Colors.white : Colors.grey,
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
                      '1 of 5',

                      style: TextStyle(
                        color: Color(0xFF2D5BDB),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Question
              const Text(
                "What's your Age?",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: kBlack,
                ),
              ),

              const SizedBox(height: 40),

              // Age Wheel
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _scrollController,

                  itemExtent: 170,

                  perspective: 0.003,

                  diameterRatio: 1.8,

                  physics: const FixedExtentScrollPhysics(),

                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedAge = index + 1;
                    });
                  },

                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 200,

                    builder: (context, index) {
                      final age = index + 1;

                      return Center(child: buildAgeItem(age));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Continue Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => const WeightScreen()),
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
