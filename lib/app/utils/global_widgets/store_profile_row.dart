import 'package:farmitra/app/constants/app_colors.dart';
import 'package:farmitra/app/utils/global_widgets/gradiant_svgIcons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:flutter_svg/flutter_svg.dart'; // For SVG handling

class StoreProfileRow extends StatelessWidget {
  final String text;
  final Gradient? gradient;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final double iconSize;
  final TextStyle? textStyle;

  StoreProfileRow({
    required this.text, // Text for the label
    this.gradient, // Gradient for the leading icon
    this.leadingIcon = Icons.storefront_outlined, // Default icon
    this.trailingIcon =
        Icons.arrow_forward_ios_rounded, // Default trailing icon
    this.iconSize = 25.0, // Default icon size
    this.textStyle, // Optional text style, defaults to custom style
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientSvgIcon(
          icon: Icon(leadingIcon), // Leading icon
          size: iconSize,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryFirstGradiant,
              AppColors.primarySecondGradiant,
            ],
          ),
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style:
              textStyle ??
              GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ), // Text style
        ),
        const Spacer(),
        Icon(
          trailingIcon,
          size: 15,
          color: AppColors.lightGrey,
        ), // Trailing arrow icon
      ],
    );
  }
}
