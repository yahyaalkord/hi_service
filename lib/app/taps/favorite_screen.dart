import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/helpers/app_color.dart';
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
        title: Text('Professions'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        children: [
          AppTextField(
              hint: 'Searching...',
              prefixIcon: Icons.search_rounded,
              keyboardType: TextInputType.text,
              controller: _searchController),
          SizedBox(
            height: 20.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsetsDirectional.only(bottom: index == 9 ? 0 : 15),
                height: 140.h,
                // width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(image: AssetImage('images/man.jpeg'),height: 100.h,width: 100.w,),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  'Yahya Alkurd',
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
                                  child: Text('Bachelor of Dental ',
                                      style: GoogleFonts.poppins(fontSize: 12.sp),
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
                                    'Study, diagnosis treatme...',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
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
              );
            },
          )
        ],
      ),
    );
  }
}
