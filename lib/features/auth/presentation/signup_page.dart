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
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    // 1. Basic validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill in all fields")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. Create the user in Supabase Auth
      await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 3. Move to preferences on success
      if (mounted) context.go('/preference');

    } on AuthException catch (e) {
      // Catch specific Supabase errors (like "Password too short")
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message), backgroundColor: Colors.redAccent));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An unexpected error occurred")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Added scroll view to prevent keyboard overflow
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text('MEDICURA', style: AppTheme.titleStyle),
              const SizedBox(height: 10),
              const Text('Create Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),

              CustomTextField(hintText: 'Email', suffixIcon: Icons.email, controller: _emailController),
              CustomTextField(hintText: 'Password', suffixIcon: Icons.lock, isPassword: true, controller: _passwordController),

              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                  : PrimaryButton(text: 'Sign Up', onPressed: _handleSignUp),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text("Already have an account? Log in", style: TextStyle(color: AppTheme.primaryTeal)),
              )
            ],
          ),
        ),
      ),
    );
  }
}