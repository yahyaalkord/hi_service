import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/get/favorite_prof_getx_controller.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/models/profession.dart';
import 'package:hi_service/utils/extenssion.dart';
import 'package:hi_service/widget/app_elevation_button.dart';

import '../helpers/app_color.dart';

class ProfessionsDetails extends StatefulWidget {
  const ProfessionsDetails({required this.profession, this.path, Key? key})
      : super(key: key);
  final String? path;
  final Profession profession;

  @override
  State<ProfessionsDetails> createState() => _ProfessionsDetailsState();
}

class _ProfessionsDetailsState extends State<ProfessionsDetails> {
  // FavoriteProfGetxController controller = FavoriteProfGetxController.to;
  bool _fav = false;

  @override
  void initState() {
    widget.path != null ? _fav = true : _fav = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsetsDirectional.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                height: 180.h,
                width: double.infinity,
                child: Image(
                  image: NetworkImage(widget.profession.imageUrl),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 165.h),
                child: Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 110.h),
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: 100.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Image(
                              image: NetworkImage(widget.profession.imageUrl),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            widget.profession.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.profession.email,
                            style: GoogleFonts.poppins(fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            widget.profession.mobile,
                            style: GoogleFonts.poppins(
                                fontSize: 12.sp, color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'specialized',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              widget.profession.specialization,
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            trailing: const Icon(
                              Icons.folder_special_outlined,
                              color: AppColors.primary,
                            ),
                            contentPadding: EdgeInsets.zero,
                            style: ListTileStyle.drawer,
                          ),
                          Divider(
                            height: 15.h,
                          ),
                          ListTile(
                            title: Text(
                              'About :',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              widget.profession.description,
                              style: GoogleFonts.poppins(fontSize: 10),
                              textAlign: TextAlign.start,
                            ),
                            trailing: const Icon(
                              Icons.info,
                              color: AppColors.primary,
                            ),
                            contentPadding: EdgeInsets.zero,
                            style: ListTileStyle.drawer,
                          ),
                          Divider(
                            height: 15.h,
                          ),
                          ListTile(
                            title: Text(
                              'Location',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              widget.profession.location,
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            trailing: const Icon(
                              Icons.location_city,
                              color: AppColors.primary,
                            ),
                            contentPadding: EdgeInsets.zero,
                            style: ListTileStyle.drawer,
                          ),
                          Divider(
                            height: 15.h,
                          ),
                          ListTile(
                            title: Text(
                              'Add To Favorite',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _fav = !_fav;
                                  });
                                  _addFavorite();
                                },
                                icon: Icon(
                                  _fav ? Icons.favorite : Icons.favorite_border,
                                  color: AppColors.primary,
                                )),
                            contentPadding: EdgeInsets.zero,
                            style: ListTileStyle.drawer,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom: 10.h, start: 20.w, end: 20.w),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _callNumber();
                      },
                      icon: const Icon(Icons.call),
                      label: Text(
                        'CallMy',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          primary: AppColors.primary,
                          minimumSize: Size(double.infinity, 50.h)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addFavorite() async {
    if (_fav == true) {
      var response = await ProfessionApiController()
          .addFavoriteProfessions(id: widget.profession.id.toString());
      context.showSnackBar(message: response.message, error: !response.success);
    }
  }

/*  void _deleteFavorite(BuildContext context , int index) async{
    if(_fav == false){
      ApiResponse apiResponse = await FavoriteProfGetxController.to.deleteFavorite(index: index);
    }

  }*/

  void _callNumber() async {
    await FlutterPhoneDirectCaller.callNumber(widget.profession.mobile);
  }
}
