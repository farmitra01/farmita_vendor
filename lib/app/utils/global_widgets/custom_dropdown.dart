import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemBuilder;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final bool showBorder;
  final Color selectedItemColor; // New property for selected item color

  const CustomDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemBuilder,
    this.borderRadius = 25.0,
    this.borderColor = AppColors.border,
    this.backgroundColor = Colors.white,
    this.showBorder = true,
    this.selectedItemColor =
        AppColors.textPrimary, // Default color for selected item
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: DropdownButton<T>(
        iconSize: 30,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            hint,
            style: GoogleFonts.montserrat(
              color: AppColors.textPrimary,
            ), // Use AppColors properly
          ),
        ),
        value: selectedItem,
        onChanged: onChanged,
        isExpanded: true,
        items:
            items.map((T item) {
              bool isSelected = item == selectedItem;
              return DropdownMenuItem<T>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    itemBuilder(item),
                    style: GoogleFonts.montserrat(
                      color:
                          isSelected
                              ? selectedItemColor
                              : AppColors.textPrimary, // Correct usage
                    ),
                  ),
                ),
              );
            }).toList(),
        style: GoogleFonts.montserrat(color: AppColors.textPrimary),
        underline: const SizedBox(),
        dropdownColor: backgroundColor,
      ),
    );
  }
}
