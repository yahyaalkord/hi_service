import 'dart:convert';
import 'dart:io';

import 'package:hi_service/api/api_settings.dart';
import 'package:hi_service/models/categorise.dart';
import 'package:hi_service/models/profession.dart';
import 'package:hi_service/models/sub_categorise.dart';

import '../prefs/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

class CategoriesApiController {
  String token = SharedPrefController().getValueFor(key: PrefKeys.token.name);

  Future<List<Categorise>> getCategories() async {
    Uri uri = Uri.parse(ApiSettings.categories);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject
          .map((jsonObject) => Categorise.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<Categorise>> search(String name) async {
    Uri uri = Uri.parse(ApiSettings.searchCategories.replaceFirst("{name}", name));
    print("uri $uri");
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    print("data ${response.body}");
    if(response.statusCode == 200){
      var json = jsonDecode(response.body) as List;
      return json.map((e) => Categorise.fromJson(e)).toList();
    }else{
      return [];
    }
  }

  //*******************

  Future<List<SubCategorise>> getSubCategories() async {
    Uri uri = Uri.parse(ApiSettings.subCategories);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject
          .map((jsonObject) => SubCategorise.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<SubCategorise>> subCategoriesSearch(String name) async {
    Uri uri = Uri.parse(ApiSettings.searchSubCategory.replaceFirst("{name}", name));
    print("uri $uri");
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    print("data ${response.body}");
    if(response.statusCode == 200){
      var json = jsonDecode(response.body) as List;
      return json.map((e) => SubCategorise.fromJson(e)).toList();
    }else{
      return [];
    }
  }

  //****************


}
