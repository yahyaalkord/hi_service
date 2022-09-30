import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_service/animation/animation_class.dart';
import 'package:hi_service/helpers/app_color.dart';

import '../prefs/shared_pref_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      bool loggedIn = SharedPrefController().getValueFor<bool>(key: PrefKeys.loggedIn.name)?? false;
      String route= loggedIn ? '/veiw_screen' : '/second_launch_screen';
      // if( SharedPrefController().getValueFor<bool>(PrefKeys.verified.name){
      //
      // }
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.primary,
      body: BounceInDown(
        child: Center(
          child: Image(
              image: const AssetImage('images/logo.png'),
              height: 100.h,
              width: 100.w),
        ),
      ),
    );
  }
}
