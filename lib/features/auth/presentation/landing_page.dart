import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background image fills the entire screen
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // NOTE: Replace this network image with your actual local asset later
            image: AssetImage()
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'MEDICURA HEALTH APP',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 180), // Pushes the buttons to the bottom

              // The Gradient Login Button
              GestureDetector(
                onTap: () => context.push('/login'), // Navigates to Login
                child: Container(
                  width: 298,
                  height: 47,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF2698C2), Color(0xFF57D0EB)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // The Sign Up RichText Link
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' Sign up',
                      style: const TextStyle(
                        color: Color(0xFF2698C2),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                      // Makes the text clickable
                      recognizer: TapGestureRecognizer()..onTap = () {
                        context.push('/signup'); // Navigates to Sign up
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}