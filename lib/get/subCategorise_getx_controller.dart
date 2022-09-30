
import 'dart:async';

import 'package:get/get.dart';
import 'package:hi_service/api/categorise_api_controller.dart';
import 'package:hi_service/api/home_api_controller.dart';
import 'package:hi_service/models/profession.dart';

import '../models/categorise.dart';
import '../models/home.dart';
import '../models/sub_categorise.dart';

class SubCategoryGetController extends GetxController with StateMixin<List<SubCategorise>>{
  RxList<SubCategorise> subCategorise = <SubCategorise>[].obs;
  RxString counter = "".obs;
  RxList<SubCategorise> searchedSubCategories = <SubCategorise>[].obs;





  void _search(String name) async {
    // searchLoading.value = true;
    change([],status: RxStatus.loading());
    if(name.isNotEmpty) {
      searchedSubCategories.value = await CategoriesApiController().subCategoriesSearch(name);
      if(searchedSubCategories.isNotEmpty) {
        change(searchedSubCategories, status: RxStatus.success());
      }else{
        print('yahya');
        change([],status: RxStatus.empty());
      }
    }else{
      change(subCategorise,status: RxStatus.success());
    }
  }

  static SubCategoryGetController get to => Get.find<SubCategoryGetController>();

  @override
  void onInit() {
    read();
    debounce(counter, (callback){
      print("object $callback");
      _search(callback.toString());
    },time: const Duration(seconds: 1));
    super.onInit();
  } // List<Product> products = <Product>[];


  void read() async {
    // loading.value = true;
    change([],status: RxStatus.loading());
    subCategorise.value = await CategoriesApiController().getSubCategories();
    // loading.value = false;
    if(subCategorise.isNotEmpty) {
      change(subCategorise, status: RxStatus.success());
    }else{
      change([],status: RxStatus.empty());
    }
  }
// void read2() async {
//   categorise = await CategoriesApiController().getCategories();
//   subCategorise = await CategoriesApiController().getSubCategories();
//   profession = await CategoriesApiController().getProfessions();
//   if(categorise != null){
//     change(categorise,status: RxStatus.success());
//   }else{
//     change([],status: RxStatus.error());
//   }
// }

}
