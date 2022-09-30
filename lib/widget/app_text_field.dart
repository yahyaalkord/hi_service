import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/helpers/app_color.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.onChange,
    this.suffixIcon,
    this.focudedBorderColor = Colors.grey,
    this.opsecure = false,
    this.format,
    Key? key,
  }) : super(key: key);
  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color focudedBorderColor;
  final bool opsecure;
  final Widget? suffixIcon;
  List<TextInputFormatter>? format = [];
  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      obscureText: opsecure,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: format,
      style: GoogleFonts.nunitoSans(),
      // maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(prefixIcon,color: AppColors.primary,),
        suffixIcon: suffixIcon,
        hintText: hint,
        helperMaxLines: 1,
        hintStyle: GoogleFonts.nunitoSans(fontSize: 16.sp),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color));
  }
}
