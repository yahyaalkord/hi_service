import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../api/auth_api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _opsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
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
              height: 5.h,
            ),
            Text(
              'Bring the best services to you',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(
              height: 40.h,
            ),
            AppTextField(
                hint: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController),
            SizedBox(
              height: 10.h,
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
                controller: _passwordController),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forget_password_screen');
                },
                child: Text(
                  'Forget Password?',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: AppColors.primary),
                ),
              ),
            ),
            Spacer(),
            AppElevationButton(text: 'Login', onPress: () async=> await _performLogin()),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: Text(
                      'CreateNow!',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ))
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _performLogin() async {
    if (_checkData()) {
      await _login();
    }
  }

  bool _checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _login() async {
    //TODO: Call login api request
    ApiResponse apiResponse = await AuthApiController().login(
        email: _emailController.text,
        password: _passwordController.text);
    if (apiResponse.success) {
      Navigator.pushReplacementNamed(context, '/veiw_screen');
    }
    context.showSnackBar(
      message: apiResponse.message,
      error: !apiResponse.success,
    );
  }
}
