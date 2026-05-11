import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2), // Pushes the logo down

              // The Logo and Text Layout
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for your actual Figma SVG logo
                  const Icon(
                    Icons.medical_information_outlined,
                    size: 80,
                    color: AppTheme.primaryTeal,
                  ),
                  const SizedBox(width: 16),

                  // The Stacked Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'MEDICURA',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryTeal,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'HEALTH APP',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryTeal,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const Spacer(flex: 3), // Pushes the button to the bottom

              // The Gradient Button with the Arrow
              PrimaryButton(
                text: 'Login',
                trailingIcon: Icons.arrow_forward,
                onPressed: () {
                  context.push('/login');
                },
              ),

              const SizedBox(height: 24),

              // The Sign Up Link
              GestureDetector(
                onTap: () {
                  context.push('/signup');
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(
                          color: AppTheme.gradientEnd, // Using the lighter teal for the text link
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}