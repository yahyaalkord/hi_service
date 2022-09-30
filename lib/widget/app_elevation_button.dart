import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppElevationButton extends StatelessWidget {
  const AppElevationButton({
    required this.text,
    required this.onPress,
    Key? key,
  }) : super(key: key);
  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          minimumSize:  Size(double.infinity, 52.h),
          primary: Color(0XFF7210FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          )
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}