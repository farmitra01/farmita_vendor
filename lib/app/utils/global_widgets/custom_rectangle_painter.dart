import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white// Fill color for the shape
      ..style = PaintingStyle.fill;

    final path = Path();

    // Define the border radius
    const double radius = 15.0;

    // Start from the top-left corner with rounded edge
    path.moveTo(0 + radius, 0);
    path.lineTo(size.width - radius, 0); // Top edge
    path.arcToPoint(
      Offset(size.width, 0 + radius),
      radius: Radius.circular(radius),
      clockwise: true,
    ); 

    // Top-right corner with radius
    path.lineTo(size.width, size.height - radius); // Right edge
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    
     // Bottom-right corner with radius
    path.lineTo(180, size.height); // Bottom edge up to the cutout
    path.arcToPoint(
      Offset(180, size.height),
      radius: Radius.circular(radius),
      clockwise: false,
    ); 
    
    // Right edge of the cutout
    path.lineTo(180, size.height - 50 + radius); // Cutout vertical edge
    path.arcToPoint(
      Offset(180 - radius, size.height - 50),
      radius: Radius.circular(radius),
      clockwise: false,
    ); 
    
    // Cutout top-right corner
    path.lineTo(radius, size.height - 50); // Cutout top edge
    path.arcToPoint(
      Offset(0, size.height - 50 - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    ); 
    
    // Cutout top-left corner
    // path.lineTo(size.width - radius, 0); // Cutout top edge
    // path.arcToPoint(
    //   Offset(radius, 0),
    //   radius: Radius.circular(radius),
    //   clockwise: true,
    // );
    path.lineTo(0, radius); // Left edge
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    ); // Top-left corner with radius

    path.close(); // Complete the path

    // Draw the shadow for the shape
    canvas.drawShadow(path, AppColors.black.withOpacity(0.25), 6, false);

    // Draw the shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint for static shapes
  }
}
