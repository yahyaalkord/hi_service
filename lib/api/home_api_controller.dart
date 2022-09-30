import 'dart:convert';
import 'dart:io';

import 'package:hi_service/api/api_settings.dart';

import '../models/home.dart';
import 'package:http/http.dart' as http;

import '../prefs/shared_pref_controller.dart';

class HomeApiController {
  Future<Home> getHomeData() async {
    // final token = SharedPrefController().getValueFor(key: PrefKeys.token.name);
    Uri uri = Uri.parse(ApiSettings.home);
    var response = await http.get(uri,headers: {
      HttpHeaders.acceptHeader : "application/json",
      HttpHeaders.authorizationHeader :SharedPrefController().getValueFor(key: PrefKeys.token.name),
    });

    if(response.statusCode == 200 || response.statusCode == 400){
      var json = jsonDecode(response.body);
      return Home.fromJson(json["data"]);
    }
    return Home();
  }
}