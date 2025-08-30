import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class OrderModel {
  final String text;
  final int number; // Rename this to avoid conflict with `int` keyword
  final Color bgColor; // Use lowercase for the field name
  final Color textColor;

  OrderModel({
    required this.text, 
    required this.number, // Corrected field name
    required this.bgColor, // Corrected field name
    required this.textColor,
  });
}
