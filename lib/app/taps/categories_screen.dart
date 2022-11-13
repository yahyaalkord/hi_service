import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_service/app/category_scbcategory_screen.dart';
import 'package:hi_service/get/home_getx_controoler.dart';
import 'package:hi_service/models/categorise.dart';
import 'package:hi_service/widget/app_text_field.dart';

import '../../animation/spinner_loading_screen.dart';
import '../../get/categorise_getx_controoler.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryGetController controller = CategoryGetController.to;
  late TextEditingController _searchController;

  // List<Categorise> categorise = <Categorise>[];

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
        title: const Text('Categories'),
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
            controller: _searchController,
          ),
          SizedBox(
            height: 30.h,
          ),
          controller.obx(
            onLoading: const Center(child: CircularProgressIndicator()),
            onEmpty: Center(
              child: Text(
                "noData",
                style: GoogleFonts.poppins(
                    fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
            (state) {
              var category = state!;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: category.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategorySubCategoriesScreen(
                                  id: category[index].id),
                            ));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image(
                              image: NetworkImage(category[index].imageUrl),
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
                                  category[index].title,
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
          /*  <CategoryGetController>(
            builder: (controller) {

              }
          )*/
        ],
      ),
    );
  }
}
