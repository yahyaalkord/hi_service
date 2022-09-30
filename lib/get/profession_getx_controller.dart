
import 'dart:async';

import 'package:get/get.dart';
import 'package:hi_service/api/categorise_api_controller.dart';
import 'package:hi_service/api/home_api_controller.dart';
import 'package:hi_service/api/profession_api_controller.dart';
import 'package:hi_service/models/profession.dart';

import '../models/categorise.dart';
import '../models/home.dart';
import '../models/sub_categorise.dart';

class ProfessionGetController extends GetxController with StateMixin<List<Profession>>{
  RxList<Profession> profession = <Profession>[].obs;
  RxString counter = "".obs;
  RxList<Profession> searchedProfession = <Profession>[].obs;
  int? subCategoriseId;


  ProfessionGetController({this.subCategoriseId});

  void _search(String name) async {
    // searchLoading.value = true;
    change([],status: RxStatus.loading());
    if(name.isNotEmpty) {
      searchedProfession.value = await ProfessionApiController().professionSearch(name);
      if(searchedProfession.isNotEmpty) {
        change(searchedProfession, status: RxStatus.success());
      }else{
        print('yahya');
        change([],status: RxStatus.empty());
      }
    }else{
      change(profession,status: RxStatus.success());
    }
  }

  static ProfessionGetController get to => Get.find<ProfessionGetController>();

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
    if(subCategoriseId!=null){
      profession.value = await ProfessionApiController().getProfessionSubCategorise(id: subCategoriseId!);
    }else{
      profession.value = await ProfessionApiController().getProfession();

    }
    // loading.value = false;
    if(profession.isNotEmpty) {
      change(profession, status: RxStatus.success());
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
