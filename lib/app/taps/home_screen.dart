import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/app/category_scbcategory_screen.dart';
import 'package:hi_service/app/profession_screen.dart';
import 'package:hi_service/get/favorite_prof_getx_controller.dart';
import 'package:hi_service/get/home_getx_controoler.dart';
import 'package:hi_service/get/profession_getx_controller.dart';
import 'package:hi_service/get/subCategorise_getx_controller.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/utils/home_section.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../../animation/spinner_loading_screen.dart';
import '../../get/categorise_getx_controoler.dart';
import '../profession_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeGetController controller = Get.put(HomeGetController());
  final categoryController = Get.lazyPut(() => CategoryGetController(),fenix: true);
  final subCategoryGetController = Get.lazyPut(() => SubCategoryGetController(),fenix: true);
  final favoriteProfGetxController = Get.lazyPut(() => FavoriteProfGetxController(),fenix: true);
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    // print('aaaa');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeGetController>(
        builder: (controller) {
          var home = controller.home;
          if(controller.loading == true){
            return Center(child:SpinnerLoadingScreen(),);
          } else if (home != null) {
          return ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.only(
                    right: 20.w, left: 20.w, top: 20.h, bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.primary,
                ),
                height: 190.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hey,',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Yahya Mohammed Alkurd',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Can I Help Yiu Something?',
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade200, fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppTextField(
                        hint: 'Searching...',
                        prefixIcon: Icons.search_rounded,
                        keyboardType: TextInputType.text,
                        controller: _searchController)
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              HomeSection(titel: 'Categorise', onPressed: () =>Navigator.pushNamed(context, '/categories_screen')),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 100.h),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                    padding: EdgeInsetsDirectional.only(start: 10.w),
                    itemCount: home.categories.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategorySubCategoriesScreen(
                                      id: home.categories[index].id),
                                ));
                          },
                          child: Stack(
                            children: [
                               Container(
                                 clipBehavior: Clip.antiAlias,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(
                                     10.r,
                                   ),
                                   color: AppColors.white,
                                 ),
                                 child: Image(
                                  image: NetworkImage(home.categories[index].imageUrl),
                                   height: double.infinity,
                                   width: double.infinity,
                                   fit: BoxFit.cover,
                              ),
                               ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 10.h),
                                child: Align(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: Text(
                                    home.categories[index].title,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12.sp,fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              HomeSection(titel: 'Sub Categorise', onPressed: () =>Navigator.pushNamed(context, '/sub_categories_screen')),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 90.h),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                    padding: EdgeInsetsDirectional.only(start: 10.w),
                    itemCount: home.subCategorise.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProfessionScreen(subCategoriseId: home.subCategorise[index].id,);
                            },));
                          },
                          child: Stack(
                            children: [
                               Container(
                                 clipBehavior: Clip.antiAlias,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(
                                     10.r,
                                   ),
                                   color: AppColors.white,
                                 ),
                                 child: Image(
                                  image: NetworkImage(home.subCategorise[index].imageUrl),
                                   height: double.infinity,
                                   width: double.infinity,
                                   fit: BoxFit.cover,
                              ),
                               ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 10.h),
                                child: Align(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: Text(
                                    home.subCategorise[index].title,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 12.sp,fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              HomeSection(titel: 'Professions', onPressed: () =>Navigator.pushNamed(context, '/professions_screen')),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300.h,
                ),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 900.h / 600.w,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: home.profession.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProfessionsDetails(
                                profession: home.profession[index],
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ),
                          color: AppColors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              home.profession[index].imageUrl,
                              height: 220.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 10.w,),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.profession[index].name,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  Divider(
                                    color: AppColors.black,
                                    height: 1.5,
                                    thickness: 0.3,
                                  ),
                                  Text(
                                    home.profession[index].description,
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          );
          } else {
            return Center(
              child: Text(
                'NO DATA',
                style: GoogleFonts.nunitoSans(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            );
          }
        },

      ),
    );
  }
}
