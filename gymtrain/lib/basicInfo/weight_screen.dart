import 'package:flutter/material.dart';
import 'fitness_level_screen.dart';

class WeightScreen extends StatefulWidget {
  final String userName;

  const WeightScreen({super.key, required this.userName});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double selectedWeight = 70;

  bool isKg = true;

  static const Color kOrange = Color(0xFFFF7A14);
  static const Color kWhite = Colors.white;
  static const Color kBlack = Color(0xFF0B0B0F);

  Widget buildUnitButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isKg = text == 'Kg';
        });
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        width: 140,
        height: 78,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),

              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        alignment: Alignment.center,

        child: Text(
          text,

          style: TextStyle(
            color: kOrange,

            fontSize: 28,

            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrange,

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
                        color: Colors.white,

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
                      color: Colors.black,
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
                      '2 of 5',

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
                "What's your current\nweight right now?",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 50),

              // Unit Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  buildUnitButton('Kg', isKg),

                  buildUnitButton('Lbs', !isKg),
                ],
              ),

              const SizedBox(height: 70),

              // Selected Weight
              Text(
                '${selectedWeight.toInt()} ${isKg ? 'Kg' : 'Lbs'}',

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 40),

              // Weight Wheel
              SizedBox(
                height: 240,

                child: ListWheelScrollView.useDelegate(
                  controller: FixedExtentScrollController(initialItem: 69),

                  itemExtent: 50,

                  diameterRatio: 20,

                  perspective: 0.002,

                  physics: const FixedExtentScrollPhysics(),

                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedWeight = (index + 1).toDouble();
                    });
                  },

                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 300,

                    builder: (context, index) {
                      final weight = index + 1;

                      bool isSelected = weight == selectedWeight.toInt();

                      return Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),

                          style: TextStyle(
                            color: Colors.white,

                            fontSize: isSelected ? 44 : 24,

                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w400,

                            shadows: isSelected
                                ? [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 12,
                                    ),
                                  ]
                                : [],
                          ),

                          child: Text(weight.toString()),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const Spacer(),

              // Continue Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          FitnessLevelScreen(userName: widget.userName),
                    ),
                  );
                },

                child: Container(
                  height: 78,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Text(
                        'Continue',

                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(width: 14),

                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
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
