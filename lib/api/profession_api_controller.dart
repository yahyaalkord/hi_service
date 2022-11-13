import 'dart:convert';
import 'dart:io';

import 'package:hi_service/api/api_settings.dart';
import 'package:hi_service/models/api_response.dart';
import 'package:hi_service/models/favorite_professions.dart';
import 'package:hi_service/models/profession.dart';
import 'package:hi_service/prefs/shared_pref_controller.dart';
import 'package:http/http.dart' as http;

class ProfessionApiController {
  String token = SharedPrefController().getValueFor(key: PrefKeys.token.name);

  Future<List<Profession>> getProfession() async {
    Uri uri = Uri.parse(ApiSettings.professions);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject
          .map((jsonObject) => Profession.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<Profession>> professionSearch(String name) async {
    Uri uri =
        Uri.parse(ApiSettings.searchProfession.replaceFirst("{name}", name));
    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      return json.map((e) => Profession.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Profession>> getProfessionSubCategorise({required int id}) async {
    Uri uri = Uri.parse(
        ApiSettings.professionsSub.replaceFirst('{id}', id.toString()));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject
          .map((jsonObject) => Profession.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<Profession>> getFavoriteProfession() async {
    Uri uri = Uri.parse(ApiSettings.favoriteProfession);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var dataJsonObject = json['data'] as List;
      return dataJsonObject
          .map((jsonObject) => Profession.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<ApiResponse> addFavoriteProfessions({required String id}) async {
    Uri uri = Uri.parse(ApiSettings.addProfessions);
    var response = await http.post(uri, body: {
      'id': id,
    }, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    // print(response.body);
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ApiResponse(json['message'], true);
      } else if (response.statusCode == 400) {
        return ApiResponse(json['message'], false);
      }
    }
    return ApiResponse('Somthing want wrong', false);
  }

  Future<ApiResponse> deleteFavoriteProfession({required int id}) async{
    Uri uri = Uri.parse(ApiSettings.deleteProfessions.replaceFirst('{id}', id.toString()));
    var response = await http.delete(uri,headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    var json = jsonDecode(response.body);
    if(response.statusCode == 200) {
      return ApiResponse(json['message'], true);
    }
    return ApiResponse(json['message'], false);
  }

  }


