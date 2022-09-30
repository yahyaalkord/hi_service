import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/api/auth_api_controller.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/models/user.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';
import 'package:hi_service/widget/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  bool _opsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
              height: 40.h,
            ),
            Text(
              'Create Account',
              style: GoogleFonts.poppins(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Please write your information below',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            AppTextField(
                hint: 'Full Name',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
                controller: _nameController),
            SizedBox(
              height: 15.h,
            ),
            AppTextField(
                hint: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController),
            SizedBox(height: 15.h),
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
              height: 15.h,
            ),
            AppTextField(
                hint: 'Phone',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
                controller: _phoneController),
            Spacer(),
            AppElevationButton(text: 'Register', onPress: () async{
              await _performRegister();
            },),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have an account?',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 12.sp),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login_screen');
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ))
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_emailController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _register() async {
   ApiResponse apiResponse = await AuthApiController().register(user);
   if(apiResponse.success){
     Navigator.pop(context);
   }
   context.showSnackBar(message: apiResponse.message,error: !apiResponse.success);
  }
  User get user {
    User user = User();
    user.name = _nameController.text;
    user.email = _emailController.text;
    user.mobile = _phoneController.text;
    user.password = _passwordController.text;
    return user;
  }
}
