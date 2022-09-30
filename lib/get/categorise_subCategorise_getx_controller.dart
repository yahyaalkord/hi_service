

import 'package:get/get.dart';
import 'package:hi_service/api/categorise_api_controller.dart';
import 'package:hi_service/api/category_sub_category_api_controller.dart';
import 'package:hi_service/models/sub_categorise.dart';

class CatSubCategoriseGetController extends GetxController with StateMixin<List<SubCategorise>>{
  RxList<SubCategorise> categoriesSubCategorise = <SubCategorise>[].obs;
  // RxString counter = "".obs;
  RxList<SubCategorise> searchedCatSubCategories = <SubCategorise>[].obs;
  int id;


  CatSubCategoriseGetController(this.id);

/*
  void _search(String name) async {
    // searchLoading.value = true;
    change([],status: RxStatus.loading());
    if(name.isNotEmpty) {
      searchedCatSubCategories.value = await CategoriesApiController().subCategoriesSearch(name);
      if(searchedCatSubCategories.isNotEmpty) {
        change(searchedCatSubCategories, status: RxStatus.success());
      }else{
        print('yahya');
        change([],status: RxStatus.empty());
      }
    }else{
      change(categoriesSubCategorise,status: RxStatus.success());
    }
  }
*/

  static CatSubCategoriseGetController get to => Get.find<CatSubCategoriseGetController>();

  @override
  void onInit() {
    read();
    /*debounce(counter, (callback){
      print("object $callback");
      _search(callback.toString());
    },time: const Duration(seconds: 1));*/
    super.onInit();
  } // List<Product> products = <Product>[];


  void read() async {
    // loading.value = true;
    change([],status: RxStatus.loading());
    categoriesSubCategorise.value = await SubCategoryApiController().getCatSubCategory(subCategoryId: id);
    // loading.value = false;
    if(categoriesSubCategorise.isNotEmpty) {
      print(categoriesSubCategorise);
      change(categoriesSubCategorise, status: RxStatus.success());
    }else{
      change([],status: RxStatus.empty());
    }
  }


}