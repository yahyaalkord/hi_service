import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/animation/spinner_loading_screen.dart';
import 'package:hi_service/app/profession_details.dart';
import 'package:hi_service/get/categorise_getx_controoler.dart';
import 'package:hi_service/get/profession_getx_controller.dart';
import 'package:hi_service/helpers/app_color.dart';
import 'package:hi_service/widget/app_text_field.dart';

class ProfessionScreen extends StatefulWidget {
  const ProfessionScreen({this.subCategoriseId, Key? key}) : super(key: key);
  final int? subCategoriseId;

  @override
  State<ProfessionScreen> createState() => _ProfessionScreenState();
}

class _ProfessionScreenState extends State<ProfessionScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<ProfessionGetController>(
        ProfessionGetController(subCategoriseId: widget.subCategoriseId));
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    Get.delete<ProfessionGetController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfessionGetController controller = ProfessionGetController.to;
    return Scaffold(
      appBar: AppBar(
        title: Text('Professions'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        children: [
          AppTextField(
              onChange: (value) {
                controller.counter.value = value;
              },
              hint: 'Searching...',
              prefixIcon: Icons.search_rounded,
              keyboardType: TextInputType.text,
              controller: _searchController),
          SizedBox(
            height: 20.h,
          ),
          controller.obx(
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: Center(
                child: Text(
                  "noData",
                  style: GoogleFonts.poppins(
                      fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ), (state) {
            var prof = state!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: prof.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfessionsDetails(
                            profession: controller.profession[index],
                          );
                        },
                      ),
                    );
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
                              child: Image(
                                image: NetworkImage(prof[index].imageUrl),
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
                                      prof[index].name,
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
                                      child: Text(prof[index].specialization,
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
                                        prof[index].description,
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
          })
        ],
      ),
    );
  }
}
