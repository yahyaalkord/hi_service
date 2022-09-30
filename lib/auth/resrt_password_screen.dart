import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/api/auth_api_controller.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../helpers/app_color.dart';
import '../prefs/shared_pref_controller.dart';
import '../widget/app_elevation_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({required this.code,required this.email,Key? key}) : super(key: key);
 final String code;
 final String email;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _passwordEditingController;
  late TextEditingController _password1EditingController;
  bool _opsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordEditingController = TextEditingController();
    _password1EditingController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _password1EditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
            ),
            Center(
              child: Image(
                image: AssetImage('images/logo2.png'),
                height: 100.h,
                width: 100.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Hi Service',
              style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary),
            ),
            SizedBox(
              height: 50.h,
            ),
            AppTextField(
                hint: 'Password',
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.text,
                opsecure: _opsecure,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _opsecure = !_opsecure);
                  },
                  icon: Icon(
                    _opsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: _passwordEditingController),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
                hint: 'Confirm Password',
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.text,
                opsecure: _opsecure,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => _opsecure = !_opsecure);
                  },
                  icon: Icon(
                    _opsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: _password1EditingController),
            Spacer(),
            AppElevationButton(text: 'Save', onPress: () =>_performReset()),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  void _performReset() {
    if (_checkData()) {
      _verify();
    }
  }

  bool _checkData() {
    if (_passwordEditingController.text.isNotEmpty &&
        _password1EditingController.text.isNotEmpty &&
        _password1EditingController.text == _passwordEditingController.text) {
      return true;
    }
    context.showSnackBar(message: 'check your required data!', error: true);
    return false;
  }

  Future<void> _verify() async{
    ApiResponse apiResponse = await AuthApiController().resetPassword(email: widget.email, code: widget.code, password: _passwordEditingController.text, confirmPassword: _password1EditingController.text);
    if(apiResponse.success){
      Navigator.pushReplacementNamed(context, '/login_screen');
      context.showSnackBar(message: apiResponse.message,);
    }
    context.showSnackBar(message: apiResponse.message,error: !apiResponse.success);
  }
}
