import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/app_color.dart';

class FavoriteProfessionsScreen extends StatefulWidget {
  const FavoriteProfessionsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteProfessionsScreen> createState() => _FavoriteProfessionsScreenState();
}

class _FavoriteProfessionsScreenState extends State<FavoriteProfessionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'),),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount:10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfessionsDetails(
                      profession: controller.profession[index],
                    );
                  },
                ),
              );*/
            },
            child: Container(
              margin:
              EdgeInsetsDirectional.only(bottom: index == 9 ? 0 : 15),
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
                    Container(
                        height: 100.h,
                        width: 100.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ),
                          color: AppColors.white,
                        ),
                        child: const Image(
                          image: AssetImage('images/man.jpeg'),
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
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
                                'yahya',
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
                                child: Text('softwareengeneer',
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
                                  'prof[index].description',
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
      ),
    );
  }
}
