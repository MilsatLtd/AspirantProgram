import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:milsat_project_app/extras/components/files.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    required this.obscureText,
    this.controller,
    this.style,
    this.keyboardType,
    this.validator,
  });

  final String hintText;
  final Widget? icon;
  final bool obscureText;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
        hintText: hintText,
        suffixIcon: icon,
        hintStyle: GoogleFonts.raleway(
          color: AppTheme.kHintTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
      ),
      style: style,
      keyboardType: keyboardType,
    );
  }
}
