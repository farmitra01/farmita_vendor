import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? text; // Made text optional
  final TextStyle? textStyle;
  final IconData? icon;
  final String? svgAssetPath;
  final double iconSize;
  final double spacing;
  final VoidCallback? onPressed;
  final BoxDecoration decoration;
  final Color? iconColor; // Fixed to Color? instead of Icon?

  const CustomOutlinedButton({
    Key? key,
    this.text,
    this.textStyle,
    this.icon,
    this.svgAssetPath,
    this.iconSize = 18.0,
    this.spacing = 8.0,
    required this.onPressed,
    required this.decoration,
    this.iconColor, // Optional color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: iconSize,
                  color: iconColor ??
                      AppColors.white), // Uses iconColor if provided, otherwise white
              SizedBox(width: spacing),
            ] else if (svgAssetPath != null) ...[
              SvgPicture.asset(svgAssetPath!,
                  height: iconSize,
                  color: iconColor ??
                      AppColors.white), // Uses iconColor if provided, otherwise white
              SizedBox(width: spacing),
            ],
            if (text != null && text!.isNotEmpty)
              Text(
                text!,
                style: textStyle ?? const TextStyle(color: AppColors.white),
              ),
          ],
        ),
      ),
    );
  }
}
