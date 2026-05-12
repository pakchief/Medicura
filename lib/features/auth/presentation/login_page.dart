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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter email and password")));
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid login credentials"), backgroundColor: Colors.redAccent));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error occurred during login")));
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text('MEDICURA', style: AppTheme.titleStyle),
              const SizedBox(height: 10),
              const Text('Welcome Back', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),

              CustomTextField(hintText: 'Email', suffixIcon: Icons.email, controller: _emailController),
              CustomTextField(hintText: 'Password', suffixIcon: Icons.lock, isPassword: true, controller: _passwordController),

              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator(color: AppTheme.primaryTeal)
                  : PrimaryButton(text: 'Login', onPressed: _handleLogin),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.go('/signup'),
                child: const Text("Don't have an account? Sign up", style: TextStyle(color: AppTheme.primaryTeal)),
              )
            ],
          ),
        ),
      ),
    );
  }
}