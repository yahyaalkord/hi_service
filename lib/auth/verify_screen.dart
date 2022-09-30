import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/auth/resrt_password_screen.dart';
import 'package:hi_service/utils/extenssion.dart';

import '../widget/app_elevation_button.dart';
import '../widget/verify_text_feild.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({required this.code, required this.email, Key? key})
      : super(key: key);
  final String email;
  final String code;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late TextEditingController _verify1TextController;
  late TextEditingController _verify2TextController;
  late TextEditingController _verify3TextController;
  late TextEditingController _verify4TextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verify1TextController = TextEditingController();
    _verify2TextController = TextEditingController();
    _verify3TextController = TextEditingController();
    _verify4TextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _verify1TextController.dispose();
    _verify2TextController.dispose();
    _verify3TextController.dispose();
    _verify4TextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            Text(
              'Code',
              style: GoogleFonts.poppins(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Text(
              'Please enter the sent code',
              style: GoogleFonts.poppins(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                VerifyTextFeild(controller: _verify1TextController),
                Spacer(),
                VerifyTextFeild(controller: _verify2TextController),
                Spacer(),
                VerifyTextFeild(controller: _verify3TextController),
                Spacer(),
                VerifyTextFeild(controller: _verify4TextController),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 80.h,
            ),
            AppElevationButton(text: 'Send', onPress: () => _performVery())
          ],
        ),
      ),
    );
  }

  void _performVery() {
    if (_checkData()) {
      _verify();
    }
  }

  bool _checkData() {
    if (_verify1TextController.text.isNotEmpty &&
        _verify2TextController.text.isNotEmpty &&
        _verify3TextController.text.isNotEmpty &&
        _verify4TextController.text.isNotEmpty) {
      if (widget.code[0] == _verify1TextController.text &&
          widget.code[1] == _verify2TextController.text &&
          widget.code[2] == _verify3TextController.text &&
          widget.code[3] == _verify4TextController.text) {
        return true;
      }
    }
    context.showSnackBar(
        message: 'Please check the entered code ', error: true);
    return false;
  }

  void _verify() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResetPasswordScreen(code: widget.code, email: widget.email),
        ));

  }
}

/*startTimer();*/
