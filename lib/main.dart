import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hi_service/app/profession_details.dart';
import 'package:hi_service/app/profession_screen.dart';
import 'package:hi_service/app/sup_categories_screen.dart';
import 'package:hi_service/app/taps/favorite_screen.dart';
import 'package:hi_service/app/taps/profile_screen.dart';
import 'package:hi_service/app/veiw_screen.dart';
import 'package:hi_service/auth/change_password_screen.dart';
import 'package:hi_service/auth/forget_password_screen.dart';
import 'package:hi_service/auth/login_screen.dart';
import 'package:hi_service/auth/register_screen.dart';
import 'package:hi_service/auth/resrt_password_screen.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/prefs/shared_pref_controller.dart';
import 'app/taps/categories_screen.dart';
import 'auth/verify_screen.dart';
import 'core/launch_screen.dart';
import 'core/second_launch_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  MaterialApp(
          localizationsDelegates: const[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          //OR
          //  localizationsDelegates: AppLocalizations.localizationsDelegates,
          //******************
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale:  const Locale('en'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor:  const Color(0XFFeceff1),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                  color: Colors.black
              ),
              titleTextStyle: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:  const Color(0XFF49a7cc),
              ),
            ),
          ),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen' : (context) => const LaunchScreen(),
            '/second_launch_screen' : (context) => const SecondLaunchScreen(),
            '/login_screen' : (context) => const LoginScreen(),
            '/forget_password_screen' : (context) => const ForgetPasswordScreen(),
            '/change_password_screen' : (context) => const ChangePasswordScreen(),
            '/register_screen' : (context) => const RegisterScreen(),
            // '/verify_screen' : (context) => const VerificationScreen(),
            // '/reset_password_screen' : (context) => const ResetPasswordScreen(),
            '/veiw_screen' : (context) => const VeiwScreen(),
            '/sub_categories_screen' : (context) => const SubCategoriesScreen(),
            '/categories_screen' : (context) => const CategoriesScreen(),
            '/favorite_screen' : (context) => const FavoriteScreen(),
            '/professions_screen' : (context) => const ProfessionScreen(),
            // '/professions_details_screen' : (context) => const ProfessionsDetails(),
          },
        );
      },

    );
  }
}