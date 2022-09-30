import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hi_service/app/taps/categories_screen.dart';
import 'package:hi_service/app/taps/favorite_screen.dart';
import 'package:hi_service/app/taps/home_screen.dart';
import 'package:hi_service/app/taps/profile_screen.dart';
import 'package:hi_service/helpers/app_color.dart';

import '../utils/bn_class.dart';

class VeiwScreen extends StatefulWidget {
  const VeiwScreen({Key? key}) : super(key: key);

  @override
  State<VeiwScreen> createState() => _VeiwScreenState();
}

class _VeiwScreenState extends State<VeiwScreen> {
  final List<BnScreen> _screens = <BnScreen>[
    const BnScreen( widget: HomeScreen()),
    const BnScreen( widget: CategoriesScreen()),
    const BnScreen( widget: FavoriteScreen()),
    const BnScreen( widget: ProfileScreen()),
  ];
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    print('object');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          // appBar: AppBar(title: Text(_screens[_currentIndex].title),),
          extendBody: true,
          backgroundColor: const Color(0xFFF0F3F8),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
              drawerTheme:DrawerThemeData()
            ),
            child: CurvedNavigationBar(
              height: 60,
              index: _currentIndex,
              color: AppColors.primary,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              buttonBackgroundColor: AppColors.primary,
              backgroundColor: Colors.transparent,
              items: const [
                Icon(Icons.home, size: 30),
                Icon(Icons.category, size: 30),
                Icon(Icons.favorite, size: 30),
                Icon(Icons.person, size: 30),


              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          body: _screens[_currentIndex].widget,
        ),
      ),
    );
  }
}
