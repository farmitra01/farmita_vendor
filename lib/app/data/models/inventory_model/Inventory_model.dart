import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InventoryModel {
  final String text;
  final String imagePath;
  final Color borderColor;
  final Color bgColor;

  InventoryModel({required this.text, required this.imagePath, required this.bgColor, required this.borderColor});
}
