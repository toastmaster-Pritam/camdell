import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTxtfield extends StatelessWidget {
  final String label;
  final bool showSuffixIcon;
  final bool required;
  final VoidCallback? onEditPressed;

  const ProfileTxtfield({
    super.key,
    this.onEditPressed,
    required this.label,
    this.showSuffixIcon = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
      child: TextFormField(
        decoration: InputDecoration(
          label: AppText(label,style: GoogleFonts.rubik(color: AppColor.primarytext,fontWeight: FontWeight.w500,fontSize: 16),),
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
        
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: showSuffixIcon
              ? Icon(Icons.edit, color: Colors.grey[400])
              : null,
        ),
        style: GoogleFonts.rubik(color: const Color(0xFF002366),fontWeight: FontWeight.w500,fontSize: 16),
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
      ),
    );
  }
}