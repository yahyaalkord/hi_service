import 'dart:convert';
import 'dart:io';

import 'package:hi_service/api/api_settings.dart';
import 'package:hi_service/models/sub_categorise.dart';
import 'package:http/http.dart' as http;

import '../prefs/shared_pref_controller.dart';

class SubCategoryApiController {
  Future<List<SubCategorise>> getCatSubCategory({required int subCategoryId}) async {
    String token = SharedPrefController().getValueFor(key: PrefKeys.token.name);
    Uri uri = Uri.parse(ApiSettings.categorySubCategory.replaceFirst('{id}', subCategoryId.toString()));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader:'application/json',
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

}