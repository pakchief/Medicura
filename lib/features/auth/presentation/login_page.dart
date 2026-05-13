import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/shared/widgets/primary_button.dart';
import 'package:medicuraapp/shared/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) context.go('/home');
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid login credentials"), backgroundColor: Colors.redAccent),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
              const SizedBox(height: 60),

              // 1. Branding Image (The "MEDICURA" text image)
              Image.asset(
                'assets/images/Medicuratext.png', // Ensure this file exists
                height: 60,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 50),

              // 2. The Background Box (Login Container)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7FA), // Light blue background box
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFF7DC6D0).withOpacity(0.25)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Username/Email Field
                    CustomTextField(
                      hintText: 'Username',
                      suffixIcon: Icons.person,
                      controller: _emailController,
                    ),

                    const SizedBox(height: 15),

                    // Password Field
                    CustomTextField(
                      hintText: 'Password',
                      suffixIcon: Icons.lock,
                      isPassword: true,
                      controller: _passwordController,
                    ),

                    const SizedBox(height: 40),

                    // Gradient Login Button
                    _isLoading
                        ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                        : PrimaryButton(
                      text: 'Login',
                      onPressed: _handleLogin,
                    ),

                    const SizedBox(height: 25),

                    // Sign Up Link
                    GestureDetector(
                      onTap: () => context.go('/signup'),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: Color(0xFF4DD0E1), // Light teal/blue
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
            ],
          ),
        ),
      ),
    );
  }
}