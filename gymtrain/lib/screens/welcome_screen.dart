import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color kOrange = Color(0xFFFF7A14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox.expand(
            child: Image.asset('assets/images/welcome.jpg', fit: BoxFit.cover),
          ),

          // Dark Overlay
          Container(color: Colors.black.withOpacity(0.45)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),

              child: Column(
                children: [
                  const Spacer(),

                  // Logo
                  Image.asset('assets/images/logo.png', width: 90),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Welcome To\nUplift.ai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Your personal fitness AI Assistant 🤖',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },

                    child: Container(
                      height: 74,

                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
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

                  const SizedBox(height: 40),

                  // Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have account? ',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },

                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: kOrange,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
