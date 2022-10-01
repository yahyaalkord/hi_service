import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/get/edit_profile_getx_controller.dart';
import 'package:hi_service/get/home_getx_controoler.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/prefs/shared_pref_controller.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../../api/auth_api_controller.dart';
import '../../models/api_response.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller =
      Get.put<EditProfileGetxController>(EditProfileGetxController());
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // print('disposep');
    Get.delete<EditProfileGetxController>(force: true);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<EditProfileGetxController>(
      builder: (controller) {
        // print(controller.user.imageUrl);
        return ListView(
          padding: const EdgeInsetsDirectional.only(top: 0),
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  color: AppColors.primary,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 25.w, end: 25.w, top: 50.h),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 50.h),
                            child: Container(
                              height: 180.h,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(20.r)),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundImage: NetworkImage(
                                          controller.user.imageUrl!),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    controller.user.name,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    controller.user.email,
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                'Name:',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                controller.user.name,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _showProfileBottomSheet(
                                      text: 'Please Enter New User Name',
                                      hint: 'New User name',
                                      prefixIcon: Icons.person,
                                      keyboardType: TextInputType.text,
                                      controller: _nameController,
                                      onPress: () {

                                        _name();
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  )),
                              contentPadding: EdgeInsets.zero,
                              style: ListTileStyle.drawer,
                            ),
                            /*Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name:',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                Text('Yahya Mohammed Alkurd',style: GoogleFonts.poppins(fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: AppColors.primary,))
                          ],
                        ),*/
                            Divider(
                              height: 20.h,
                            ),
                            ListTile(
                              title: Text(
                                'Email:',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                controller.user.email,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _showProfileBottomSheet(
                                        text: 'Please Enter New User email',
                                        hint: 'New User email',
                                        prefixIcon: Icons.email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailController,
                                        onPress: () {
                                          _email();
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  )),
                              contentPadding: EdgeInsets.zero,
                              style: ListTileStyle.drawer,
                            ),
                            /*Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email:',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                Text('yahyaalkurd98@gmail.com',style: GoogleFonts.poppins(fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: AppColors.primary,))
                          ],
                        ),*/
                            Divider(
                              height: 20.h,
                            ),
                            ListTile(
                              title: Text(
                                'Phone:',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                controller.user.mobile,
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    _showProfileBottomSheet(
                                      text: 'Please Enter New User Mobile',
                                      hint: 'New User Mobile',
                                      prefixIcon: Icons.call,
                                      keyboardType: TextInputType.phone,
                                      controller: _phoneController,
                                      onPress: () => _phone(),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  )),
                              contentPadding: EdgeInsets.zero,
                              style: ListTileStyle.drawer,
                            ),
                            /*Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone:',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                                Text('0595430134',style: GoogleFonts.poppins(fontSize: 12),),
                              ],
                            ),
                            Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: AppColors.primary,))
                          ],
                        ),*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, '/change_password_screen'),
                              child: ListTile(
                                title: Text(
                                  'Change Password',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/change_password_screen');
                                    },
                                    icon: const Icon(
                                      Icons.lock_open,
                                      color: AppColors.primary,
                                    )),
                                contentPadding: EdgeInsets.zero,
                                style: ListTileStyle.drawer,
                              ),
                            ),
                            Divider(
                              height: 20.h,
                            ),
                            InkWell(
                              onTap: () => _confirmLogoutDialog(),
                              child: ListTile(
                                title: Text(
                                  'Logout',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.logout,
                                      color: AppColors.primary,
                                    )),
                                contentPadding: EdgeInsets.zero,
                                style: ListTileStyle.drawer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100.h,
            ),
          ],
        );
      },
    ));
  }

  void _showProfileBottomSheet(
      {required String text,
      required String hint,
      required IconData prefixIcon,
      required TextInputType keyboardType,
      required TextEditingController controller,
      required void Function() onPress}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                              hint: hint,
                              prefixIcon: prefixIcon,
                              keyboardType: keyboardType,
                              controller: controller),
                          const Spacer(),
                          AppElevationButton(text: 'Update', onPress: onPress)
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }

  void _confirmLogoutDialog() async {
    showDialog<bool>(
      context: context,
      // barrierColor: Colors.red.shade100.withOpacity(0.5),
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
          ),
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 16,
            color: Colors.black,
          ),
          content: Text(
            'Are you sure you are logged out!',
            style: GoogleFonts.tajawal(),
          ),
          contentTextStyle: GoogleFonts.cairo(
            fontSize: 13,
            color: Colors.black45,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                ApiResponse apiResponse = await AuthApiController().logout();
                if (apiResponse.success) {
                  Navigator.pop(context);

                }
              },
              child: Text(
                'yes',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    ).then((value) {
      Get.delete<HomeGetController>(force: true);
      Navigator.pushNamedAndRemoveUntil(context, '/login_screen', (route) => false);
    });
  }

  void _phone() async{
    if (_phoneController.text.isEmpty) {
      Navigator.pop(context);
    }else {
      var response = await controller.editProfile(
          value: _phoneController.text, editRequstType: EditRequstType.mobile);
      Navigator.pop(context);
      context.showSnackBar(message: response.message, error: !response.success);
    }
  }

  void _email() async{
    if (_emailController.text.isEmpty) {
      Navigator.pop(context);
    }else {
      var response = await controller.editProfile(
          value: _emailController.text, editRequstType: EditRequstType.email);
      Navigator.pop(context);
      context.showSnackBar(message: response.message, error: !response.success);
    }
  }

  void _name() async {
    if (_nameController.text.isEmpty) {
      Navigator.pop(context);
    }else {
      var response = await controller.editProfile(
          value: _nameController.text, editRequstType: EditRequstType.name);
      Navigator.pop(context);
      context.showSnackBar(message: response.message, error: !response.success);
    }
  }
}
