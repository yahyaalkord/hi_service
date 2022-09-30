import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/get/edit_profile_getx_controller.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';
import 'package:hi_service/widget/app_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _opsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Change Password',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 22.sp),
            ),
            SizedBox(
              height: 40.h,
            ),
            AppTextField(
              hint: 'Current password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _currentPasswordController,
              opsecure: _opsecure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _opsecure = !_opsecure);
                },
                icon: Icon(
                  _opsecure ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: 'new password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _newPasswordController,
              opsecure: _opsecure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _opsecure = !_opsecure);
                },
                icon: Icon(
                  _opsecure ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: 'confirm password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _confirmPasswordController,
              opsecure: _opsecure,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _opsecure = !_opsecure);
                },
                icon: Icon(
                  _opsecure ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppElevationButton(
              text: 'change password',
              onPress: () =>_performChange(),
            ),
          ],
        ),
      ),
    );
  }

  void _performChange() {
    if (_checkData()) {
      _change();
    }
  }

  bool _checkData() {
    if (_currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'enter you required data!', error: true);
    return false;
  }

  void _change() async {
    var response = await EditProfileGetxController.to.changPassword(
        password: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmNewPassword: _confirmPasswordController.text);
    context.showSnackBar(message: response.message, error: !response.success);
    if (response.success) {
      Navigator.pop(context);
    }
  }
}
