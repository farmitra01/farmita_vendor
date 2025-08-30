import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientOutlinedButton extends StatelessWidget {
  final String? text; // Nullable text
  final Widget? customChild; // Optional custom child widget
  final Gradient gradient;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final bool showText; // Boolean flag to decide between text and customChild

  GradientOutlinedButton({
    this.text,
    this.customChild,
    required this.gradient,
    required this.onPressed,
    required this.borderRadius,
    this.showText = true, // Default to true for showing text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient, borderRadius: borderRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background,

            borderRadius: borderRadius,
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.transparent),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            onPressed: onPressed,
            child:
                showText && text != null
                    ? Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryGradinatMixColor,
                      ),
                    )
                    : customChild ??
                        Container(), // Use customChild or empty if null
          ),
        ),
      ),
    );
  }
}
