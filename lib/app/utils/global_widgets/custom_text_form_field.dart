import 'package:dotted_border/dotted_border.dart';
import 'package:farmitra/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Icon? prefixIcon;
  final Widget? prefixWidget; // Added prefixWidget
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onSuffixIconTap;
  final double borderRadius;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool isDottedBorder;
  final Function(String)? onChanged;
  final bool readOnly;

  CustomTextFormField({
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.prefixWidget, // Constructor param
    this.suffixIcon,
    this.suffixWidget,
    this.onSuffixIconTap,
    this.borderRadius = 25.0,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.isDottedBorder = false,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget textField = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      readOnly: readOnly,
      inputFormatters: [
        if (inputFormatters != null) ...inputFormatters!,
        if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: onChanged,
      cursorColor: AppColors.primaryGradinatMixColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        counterText: "",
        focusedBorder:
            isDottedBorder
                ? InputBorder.none
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide:  BorderSide(
                    color: AppColors.primaryGradinatMixColor,
                  ),
                ),
        enabledBorder:
            isDottedBorder
                ? InputBorder.none
                : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        prefixIcon: prefixWidget ?? prefixIcon, // Prioritize prefixWidget
        suffixIcon:
            suffixWidget ??
            (suffixIcon != null
                ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: Icon(suffixIcon, color: AppColors.secondary),
                )
                : null),
      ),
    );

    return isDottedBorder
        ? DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(borderRadius),
          dashPattern: [6, 3],
          color: AppColors.border,
          strokeWidth: 1.5,
          child: Padding(padding: const EdgeInsets.all(4.0), child: textField),
        )
        : textField;
  }
}
