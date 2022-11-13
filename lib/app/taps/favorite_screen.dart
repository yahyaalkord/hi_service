import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/app/profession_details.dart';
import 'package:hi_service/get/favorite_prof_getx_controller.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/models/profession.dart';
import 'package:hi_service/widget/app_text_field.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
        ),
        body: FutureBuilder<List<Profession>>(
          future: ProfessionApiController().getFavoriteProfession(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              var favorite = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsetsDirectional.only(top: 20.h,start: 15.w,end: 15.w,bottom: 60.h),
                itemCount: favorite.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProfessionsDetails(
                            profession: favorite[index],
                            path: 'x',
                          );
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                          bottom: index == 9 ? 0 : 15),
                      height: 140.h,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: NetworkImage(favorite[index].imageUrl),
                              height: 100.h,
                              width: 100.w,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Name: ',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        favorite[index].name,
                                        style: GoogleFonts.nunitoSans(),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Specialize: ',
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                      Expanded(
                                        child: Text(
                                            favorite[index].specialization,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'sbout: ',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                      Expanded(
                                        child: Text(
                                          favorite[index].description,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No DATA',
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              );
            }
          },
        ));
  }
}
