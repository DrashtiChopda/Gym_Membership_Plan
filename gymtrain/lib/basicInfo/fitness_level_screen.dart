import 'dart:math';
import 'package:flutter/material.dart';
import 'gender_screen.dart';

class FitnessLevelScreen extends StatefulWidget {
  final String userName;

  const FitnessLevelScreen({super.key, required this.userName});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  double progress = 0.3;

  int level = 3;

  String levelText = "Somewhat Athletic";

  static const Color kOrange = Color(0xFFFF7A14);

  static const Color kBlack = Color(0xFF0B0B0F);

  void updateLevel(double value) {
    setState(() {
      progress = value;

      level = ((value * 5).ceil()).clamp(1, 5);

      switch (level) {
        case 1:
          levelText = "Beginner";
          break;

        case 2:
          levelText = "Average";
          break;

        case 3:
          levelText = "Somewhat Athletic";
          break;

        case 4:
          levelText = "Athletic";
          break;

        case 5:
          levelText = "Elite Athlete";
          break;
      }
    });
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
                      '3 of 5',

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

              // Heading
              const Text(
                "How would you rate\nyour fitness level?",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: kBlack,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 40),

              // Hint
              Row(
                children: const [
                  Icon(Icons.help, color: Colors.grey, size: 26),

                  SizedBox(width: 10),

                  Text(
                    'Drag to adjust',

                    style: TextStyle(
                      color: Color(0xFF3E4048),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Arc Slider
              Expanded(
                child: Stack(
                  alignment: Alignment.center,

                  children: [
                    SizedBox(
                      width: 350,
                      height: 350,

                      child: CustomPaint(
                        painter: ArcPainter(progress: progress),
                      ),
                    ),

                    Positioned(
                      top: 50,

                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            progress += details.delta.dx / 300;

                            progress = progress.clamp(0.0, 1.0);

                            updateLevel(progress);
                          });
                        },

                        child: Transform.rotate(
                          angle: progress * pi,

                          child: Container(
                            width: 90,
                            height: 90,

                            decoration: BoxDecoration(
                              color: kOrange,

                              borderRadius: BorderRadius.circular(28),
                            ),

                            child: const Icon(
                              Icons.fitness_center_rounded,

                              color: Colors.white,
                              size: 38,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 80,

                      child: Column(
                        children: [
                          Text(
                            '$level',

                            style: const TextStyle(
                              fontSize: 160,
                              fontWeight: FontWeight.w900,
                              color: kBlack,
                              height: 0.9,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            levelText,

                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E4048),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Continue Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => GenderScreen(userName: widget.userName),
                    ),
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

// Arc Painter
class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final backgroundPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFFFF7A14)
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, pi * 0.75, pi * 0.75, false, backgroundPaint);

    canvas.drawArc(rect, pi * 0.75, pi * 0.75 * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
