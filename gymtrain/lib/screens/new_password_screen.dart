// File: lib/screens/new_password_screen.dart

import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  static const Color kBlack = Color(0xFF0B0B0F);
  static const Color kGreyText = Color(0xFF6E717A);
  static const Color kCard = Color(0xFFF2F2F2);
  static const Color kOrange = Color(0xFFFF7A14);
  static const Color kGreen = Color(0xFF22C55E);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password strength helpers
  bool get _hasMinLength => _newPasswordController.text.length >= 8;
  bool get _hasUppercase =>
      _newPasswordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _newPasswordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial =>
      _newPasswordController.text.contains(RegExp(r'[!@#\$%^&*]'));

  int get _strengthScore => [
    _hasMinLength,
    _hasUppercase,
    _hasNumber,
    _hasSpecial,
  ].where((e) => e).length;

  Color get _strengthColor {
    if (_strengthScore <= 1) return Colors.redAccent;
    if (_strengthScore == 2) return Colors.orange;
    if (_strengthScore == 3) return Colors.amber;
    return kGreen;
  }

  String get _strengthLabel {
    if (_strengthScore <= 1) return 'Weak';
    if (_strengthScore == 2) return 'Fair';
    if (_strengthScore == 3) return 'Good';
    return 'Strong';
  }

  void _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });

    // Navigate back to login after success
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Pop back to the root (login screen)
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kBlack,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFBDBDBD),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(prefixIcon, color: kGreyText),
            suffixIcon: GestureDetector(
              onTap: onToggle,
              child: Icon(
                isVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: kGreyText,
              ),
            ),
            filled: true,
            fillColor: kCard,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: kOrange, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildStrengthIndicator() {
    if (_newPasswordController.text.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 6 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: i < _strengthScore ? _strengthColor : kCard,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          'Password strength: $_strengthLabel',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _strengthColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStrengthHint(String text, bool met) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 16,
            color: met ? kGreen : const Color(0xFFBDBDBD),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: met ? kBlack : kGreyText,
              fontWeight: met ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isSuccess ? _buildSuccessView() : _buildFormView(),
      ),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: kGreen.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: kGreen,
                size: 60,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Password Reset!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: kBlack,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Your password has been updated\nsuccessfully. Redirecting to login…',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: kGreyText,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(color: kOrange, strokeWidth: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
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

            // Lock icon header
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: kOrange,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),

            const SizedBox(height: 28),

            // Title
            const Text(
              'Create New\nPassword',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: kBlack,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),

            const SizedBox(height: 14),

            // Email chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.email_rounded, size: 16, color: kGreyText),
                  const SizedBox(width: 6),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kGreyText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // New Password field
            _buildPasswordField(
              controller: _newPasswordController,
              label: 'New Password',
              hint: 'Enter new password',
              isVisible: _showNewPassword,
              onToggle: () =>
                  setState(() => _showNewPassword = !_showNewPassword),
              prefixIcon: Icons.lock_outline_rounded,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),

            // Strength indicator
            _buildStrengthIndicator(),

            const SizedBox(height: 8),

            // Strength hints
            if (_newPasswordController.text.isNotEmpty) ...[
              _buildStrengthHint('At least 8 characters', _hasMinLength),
              _buildStrengthHint('One uppercase letter', _hasUppercase),
              _buildStrengthHint('One number', _hasNumber),
              _buildStrengthHint(
                'One special character (!@#\$%^&*)',
                _hasSpecial,
              ),
            ],

            const SizedBox(height: 24),

            // Confirm Password field
            _buildPasswordField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              isVisible: _showConfirmPassword,
              onToggle: () =>
                  setState(() => _showConfirmPassword = !_showConfirmPassword),
              prefixIcon: Icons.lock_outline_rounded,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            // Update Button
            GestureDetector(
              onTap: _isLoading ? null : _resetPassword,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 68,
                decoration: BoxDecoration(
                  color: _isLoading ? kBlack.withOpacity(0.6) : kBlack,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoading)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    else ...[
                      const Text(
                        'Update Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
