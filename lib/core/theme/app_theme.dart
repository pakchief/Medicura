import 'package:flutter/material.dart';

class AppTheme {
  // The main text color ("MEDICURA", "Sign up")
  static const Color primaryTeal = Color(0xFF2FAAD4);

  // The gradient colors for the button
  static const Color gradientStart = Color(0xFF32A9D9);
  static const Color gradientEnd = Color(0xFF5CE1E6);

  // The light icy-blue background of the login card
  static const Color cardBackground = Color(0xFFE8F6F8);

  // Standard text
  static const Color textDark = Colors.black;

  // The button gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: primaryTeal,
  );
}