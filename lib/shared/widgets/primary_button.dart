import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? trailingIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient, // Using your new Figma gradient here!
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The Centered Text
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // The Right-Aligned Icon (Only shows if provided)
                if (trailingIcon != null)
                  Positioned(
                    right: 0,
                    child: Icon(
                      trailingIcon,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}