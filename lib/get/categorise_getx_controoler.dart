
import 'dart:async';

import 'package:get/get.dart';
import 'package:hi_service/api/categorise_api_controller.dart';
import 'package:hi_service/api/home_api_controller.dart';
import 'package:hi_service/models/profession.dart';

import '../models/categorise.dart';
import '../models/home.dart';
import '../models/sub_categorise.dart';

class CategoryGetController extends GetxController with StateMixin<List<Categorise>>{
  RxList<Categorise> categorise = <Categorise>[].obs;
  // RxList<SubCategorise> subCategorise = <SubCategorise>[].obs;
  // RxList<Profession> profession = <Profession>[].obs;
  RxBool loading = false.obs;
  RxString counter = "".obs;
  RxList<Categorise> searchedCategories = <Categorise>[].obs;





  void _search(String name) async {
    // searchLoading.value = true;
    change([],status: RxStatus.loading());
    if(name.isNotEmpty) {
      searchedCategories.value = await CategoriesApiController().search(name);
      if(searchedCategories.isNotEmpty) {
        change(searchedCategories, status: RxStatus.success());
      }else{
        print('yahya');
        change([],status: RxStatus.empty());
      }
    }else{
      change(categorise,status: RxStatus.success());
    }
  }

  static CategoryGetController get to => Get.find<CategoryGetController>();

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
    categorise.value = await CategoriesApiController().getCategories();
    // subCategorise.value = await CategoriesApiController().getSubCategories();
    // profession.value = await CategoriesApiController().getProfessions();
    // loading.value = false;
    if(categorise.isNotEmpty) {
      change(categorise, status: RxStatus.success());
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
