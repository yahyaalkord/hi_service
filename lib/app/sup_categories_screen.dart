import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/app/profession_screen.dart';
import 'package:hi_service/get/categorise_getx_controoler.dart';
import 'package:hi_service/get/subCategorise_getx_controller.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../animation/spinner_loading_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  SubCategoryGetController controller = SubCategoryGetController.to;
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
        title: const Text('SubCategories'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        shrinkWrap: true,
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
            height: 30.h,
          ),
          controller.obx(
              onLoading: const Center(child: CircularProgressIndicator()),
              onEmpty: Text(
                "noData",
                style: GoogleFonts.poppins(
                    fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
                  (state) {
            var subcategory = state!;
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: subcategory.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ProfessionScreen(subCategoriseId: subcategory[index].id,);
                      },));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(subcategory[index].imageUrl),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Text(
                                subcategory[index].title,
                                style:
                                    GoogleFonts.nunitoSans(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          })
        ],
      ),
    );
  }
}
