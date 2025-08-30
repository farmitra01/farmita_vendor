import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientSvgIcon extends StatelessWidget {
  final String? assetName;
  final Icon? icon;
  final double size;
  final Gradient gradient;

  GradientSvgIcon({
    this.icon, // Optional icon
    this.assetName, // Optional asset name
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: assetName != null
          ? SvgPicture.asset(
              assetName!,
              width: size,
              height: size,
              colorFilter: const ColorFilter.mode(
                Colors.white, // The color is set to white so the gradient shows up correctly
                BlendMode.srcIn,
              ),
            )
          : (icon != null
              ? Icon(
                  icon!.icon, // Use the provided icon's icon data
                  size: size,
                  color: Colors.white, // Color needs to be white for the gradient to apply
                )
              : const SizedBox()), // Fallback if neither assetName nor icon is provided
    );
  }
}
