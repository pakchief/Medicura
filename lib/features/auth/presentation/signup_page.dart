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
    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) context.go('/preference');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            CustomTextField(hintText: 'Email', suffixIcon: Icons.email, controller: _emailController),
            CustomTextField(hintText: 'Password', suffixIcon: Icons.lock, isPassword: true, controller: _passwordController),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : PrimaryButton(text: 'Sign Up', onPressed: _handleSignUp),
          ],
        ),
      ),
    );
  }
}