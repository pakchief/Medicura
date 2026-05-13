import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';
import 'package:medicuraapp/shared/widgets/primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/landing_page.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LOGO + TEXT (Centered Column)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/logo_blue.png",
                      height: 120, // Increased size for a centered look
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'MEDICURA\nHEALTH APP',
                      textAlign: TextAlign.center, // Centers the lines of text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),

                // BUTTONS (Bottom Section)
                Column(
                  children: [
                    PrimaryButton(
                      text: 'Login',
                      onPressed: () => context.push('/login'),
                      trailingIcon: Icons.arrow_forward,
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () => context.push('/signup'),
                      child: const Text.rich(
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                color: Color(0xFF57D0EB),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}