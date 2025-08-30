import 'package:flutter/material.dart';

class StoreTemplateModel {
  final Color backgroundColor;
  final Color spanTextColor;
  final String bannerImage;

  StoreTemplateModel(
      {required this.backgroundColor,
      required this.spanTextColor,
      required this.bannerImage});

  @override
  String toString() {
    return 'StoreTemplateModel(backgroundColor: $backgroundColor, spanTextColor: $spanTextColor, bannerImage: $bannerImage)';
  }
  
}
