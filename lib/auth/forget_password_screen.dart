import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/api/auth_api_controller.dart';
import 'package:hi_service/auth/verify_screen.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';
import 'package:hi_service/widget/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Text(
              'Forget Password!',
              style: GoogleFonts.poppins(
                  fontSize: 24.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              '''Please enter your email below and 
we will send you the OTP code''',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            AppTextField(
                hint: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController),
            SizedBox(
              height: 20.h,
            ),
            AppElevationButton(text: 'Send', onPress: () async {
              await _performReset();
            })
          ],
        ),
      ),
    );
  }

  Future<void> _performReset() async{
    if (_checkData()) {
     await _verify();
    }
  }

  bool _checkData() {
    if (_emailController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'enter your required data!', error: true);
    return false;
  }

  Future<void> _verify() async {
    ApiResponse<String> apiResponse =
        await AuthApiController().forgetPassword(email: _emailController.text);
    if (apiResponse.success) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(email: _emailController.text,code: apiResponse.object!,),));
    }
    context.showSnackBar(
        message: apiResponse.message, error: !apiResponse.success);
  }
}
