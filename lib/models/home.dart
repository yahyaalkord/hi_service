
import 'package:hi_service/models/profession.dart';
import 'package:hi_service/models/sub_categorise.dart';

import 'categorise.dart';

class Home{
  List<Categorise> categories = [];
  List<SubCategorise> subCategorise = [];
  List<Profession> profession = [];

  Home();

  Home.fromJson(Map<String,dynamic> json){
    var categoriesJson = json['category'] as List;
    categories = categoriesJson.map((e) => Categorise.fromJson(e)).toList();
    var subCategoriseJson = json['subCategories'] as List;
    subCategorise = subCategoriseJson.map((e) => SubCategorise.fromJson(e)).toList();
    var professionJson = json['profession'] as List;
    profession = professionJson.map((e) => Profession.fromJson(e)).toList();

  }


}

