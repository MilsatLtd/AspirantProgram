import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../extras/components/files.dart';

class MeetupFormField extends StatelessWidget {
  const MeetupFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      cursorWidth: 1.5,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.kHintTextColor,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.raleway(
          color: const Color(0xFFB7B6B8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
      ),
    );
  }
}
