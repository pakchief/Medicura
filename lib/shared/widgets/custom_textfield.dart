import 'package:flutter/material.dart';
import 'package:medicuraapp/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData suffixIcon;
  final bool isPassword;
  final TextEditingController? controller; // Add this line

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    this.isPassword = false,
    this.controller, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller, // Add this line
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Icon(suffixIcon, color: AppTheme.primaryTeal),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppTheme.primaryTeal),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppTheme.primaryTeal.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}