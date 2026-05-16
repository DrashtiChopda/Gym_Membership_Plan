import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtrain/basicInfo/age_screen.dart';
import 'login_screen.dart'; // ← connects to LoginScreen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _confirmHasError = false;
  bool _isConfirmFocused = false;

  // ── Brand Colors ──────────────────────────────────────────────
  static const Color kOrange = Color(0xFFE8722A);
  static const Color kBlack = Color(0xFF0F0F0F);
  static const Color kFieldBg = Color(0xFFF2F2F2);
  static const Color kRed = Color(0xFFE53935);
  static const Color kRedBg = Color(0xFFFFEBEB);
  // ──────────────────────────────────────────────────────────────

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _validateConfirm(String value) {
    setState(() {
      _confirmHasError = value.isNotEmpty && value != _passwordController.text;
    });
  }

  void _onSignUp() {
    final password = _passwordController.text;

    final confirm = _confirmController.text;

    if (confirm != password) {
      setState(() {
        _confirmHasError = true;
      });

      return;
    }

    setState(() {
      _confirmHasError = false;
    });

    Navigator.pushReplacement(
      context,

      MaterialPageRoute(builder: (_) => const AgeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Hero ─────────────────────────────────────────
              _HeroSection(),

              // ── Form ─────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),

                    // Email
                    _FieldLabel(label: 'Email Address'),
                    const SizedBox(height: 8),
                    _PlainInputField(
                      controller: _emailController,
                      hint: 'elementary221b@gmail.com',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    _FieldLabel(label: 'Password'),
                    const SizedBox(height: 8),
                    _PasswordInputField(
                      controller: _passwordController,
                      obscure: _obscurePassword,
                      hasError: false,
                      onToggle: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password
                    _FieldLabel(label: 'Confirm Password'),
                    const SizedBox(height: 8),
                    _PasswordInputField(
                      controller: _confirmController,
                      obscure: _obscureConfirm,
                      hasError: _confirmHasError,
                      onChanged: _validateConfirm,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),

                    // Error banner
                    if (_confirmHasError) ...[
                      const SizedBox(height: 10),
                      _ErrorBanner(),
                    ],

                    const SizedBox(height: 28),

                    // Sign Up button
                    _SignUpButton(onTap: _onSignUp),

                    const SizedBox(height: 28),

                    // Already have account
                    _SignInLink(),

                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Hero Section
// ─────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/gym_bg.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: const Color(0xFFEEEEEE)),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.88),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // App Icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8722A),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE8722A).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(38, 38),
                    painter: _AtomIconPainter(),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Sign Up For Free',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F0F0F),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Quickly make your account in 1 minute',
                style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

class _AtomIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.32;
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(i * 60 * 3.14159 / 180);
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: r * 2, height: r * 0.7),
        paint,
      );
      canvas.restore();
    }
    canvas.drawCircle(Offset(cx, cy), 3.5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_AtomIconPainter old) => false;
}

// ─────────────────────────────────────────────────────────────────
// Field Label
// ─────────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F0F0F),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Plain Input (Email)
// ─────────────────────────────────────────────────────────────────
class _PlainInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;

  const _PlainInputField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 15, color: Color(0xFF0F0F0F)),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(prefixIcon, color: const Color(0xFF888888), size: 22),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Password / Confirm Password Input
// ─────────────────────────────────────────────────────────────────
class _PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final bool hasError;
  final VoidCallback onToggle;
  final ValueChanged<String>? onChanged;

  static const Color kRed = Color(0xFFE53935);
  static const Color kFieldBg = Color(0xFFF2F2F2);

  const _PasswordInputField({
    required this.controller,
    required this.obscure,
    required this.hasError,
    required this.onToggle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: kFieldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasError ? kRed : Colors.transparent,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 15, color: Color(0xFF0F0F0F)),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.lock_outline_rounded,
              color: hasError ? kRed : const Color(0xFF888888),
              size: 22,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: hasError ? kRed : const Color(0xFF888888),
                size: 22,
              ),
            ),
          ),
          hintText: '••••••••••',
          hintStyle: const TextStyle(color: Color(0xFF999999), fontSize: 18),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Error Banner
// ─────────────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  static const Color kRed = Color(0xFFE53935);
  static const Color kRedBg = Color(0xFFFFEBEB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: kRedBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kRed.withOpacity(0.4), width: 1.5),
      ),
      child: Row(
        children: const [
          Icon(Icons.error_outline_rounded, color: kRed, size: 22),
          SizedBox(width: 10),
          Text(
            "ERROR: Password Don't Match!",
            style: TextStyle(
              color: kRed,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Sign Up Button
// ─────────────────────────────────────────────────────────────────
class _SignUpButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SignUpButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xFF0F0F0F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// "Already have an account? Sign In." — navigates to LoginScreen
// ─────────────────────────────────────────────────────────────────
class _SignInLink extends StatelessWidget {
  static const Color kOrange = Color(0xFFE8722A);
  static const Color kTextGrey = Color(0xFF888888);

  const _SignInLink();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        },
        child: RichText(
          text: const TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: kTextGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: 'Sign In.',
                style: TextStyle(color: kOrange, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
