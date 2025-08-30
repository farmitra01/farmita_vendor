import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmitra/app/constants/app_colors.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final String? text2;
  final VoidCallback onPressed;
  final IconData? icon;
  final double? width;
  final double? height;
  final double borderRadius;
  final List<Color> gradientColors;
  final double iconSpacing;

  const CustomGradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.text2,
    this.icon,
    this.width,
    this.height,
    this.borderRadius = 25,
   this.gradientColors =  const [
  AppColors.primaryFirstGradiant,
  AppColors.primarySecondGradiant,
],
    this.iconSpacing = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: onPressed,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.white, size: 18),
                  SizedBox(width: iconSpacing),
                ],
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    if (text2 != null) ...[
                      SizedBox(height: 4.0),
                      Text(
                        text2!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ],
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
