// File: lib/screens/reset_screen.dart

import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  static const Color kBlack = Color(0xFF0B0B0F);
  static const Color kGreyText = Color(0xFF6E717A);
  static const Color kCard = Color(0xFFF2F2F2);
  static const Color kOrange = Color(0xFFFF7A14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Title
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: kBlack,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Select the method you'd like to reset.",
                style: TextStyle(fontSize: 18, color: kGreyText, height: 1.4),
              ),

              const SizedBox(height: 40),

              // Email Card
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: kCard,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Icon(
                        Icons.email_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Send via Email',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: kBlack,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            'Seamlessly reset your\npassword via email address.',
                            style: TextStyle(
                              fontSize: 16,
                              color: kGreyText,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFFBDBDBD),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Reset Button
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password reset link sent to your email'),
                    ),
                  );
                },
                child: Container(
                  height: 68,
                  decoration: BoxDecoration(
                    color: kBlack,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(width: 12),

                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
