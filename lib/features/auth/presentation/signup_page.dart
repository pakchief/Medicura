import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/shared/widgets/primary_button.dart';
import 'package:medicuraapp/shared/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // New Controller
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    // 1. Validation: Check for empty fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Please fill in all fields");
      return;
    }

    // 2. Validation: Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar("Passwords do not match");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 3. Create user in Supabase
      await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) context.go('/preference'); // Move to user preferences
    } on AuthException catch (e) {
      _showSnackBar(e.message);
    } catch (e) {
      _showSnackBar("An unexpected error occurred");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Branding Image
              Image.asset(
                'assets/images/Medicuratext.png',
                height: 60,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 30),

              // The Background Box (Sign Up Container)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7FA), // Light blue box matching image_1d9430.png
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFB2EBF2).withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),

                    CustomTextField(
                      hintText: 'Email',
                      suffixIcon: Icons.email,
                      controller: _emailController,
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: 'Password',
                      suffixIcon: Icons.lock,
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 15),

                    // NEW: Confirm Password Field
                    CustomTextField(
                      hintText: 'Confirm Password',
                      suffixIcon: Icons.lock_outline,
                      isPassword: true,
                      controller: _confirmPasswordController,
                    ),

                    const SizedBox(height: 30),

                    _isLoading
                        ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                        : PrimaryButton(
                      text: 'Sign Up',
                      onPressed: _handleSignUp,
                    ),

                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: Color(0xFF4DD0E1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}