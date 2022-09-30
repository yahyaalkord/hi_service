import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/animation/animation_class.dart';

import '../helpers/app_color.dart';

class SecondLaunchScreen extends StatefulWidget {
  const SecondLaunchScreen({Key? key}) : super(key: key);

  @override
  State<SecondLaunchScreen> createState() => _SecondLaunchScreenState();
}

class _SecondLaunchScreenState extends State<SecondLaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          Image(
            image: AssetImage('images/home.png'),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ZoomIn(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90.h,
                ),
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 135.h,
                  width: 135.w,
                ),
                SizedBox(
                  height: 135.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    '''Have a problem
that you can solved?
Don’t worry, lets
get started.''',
                    style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 60.h),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login_screen');
                      },
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color:AppColors.primary),
                      )),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
