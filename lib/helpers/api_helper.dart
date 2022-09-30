import 'dart:io';

import 'package:hi_service/models/api_response.dart';

import '../prefs/shared_pref_controller.dart';


mixin ApiHelper {
  ApiResponse get errorResponse => ApiResponse('Something went wrong', false);

  Map<String, String> get headers => {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: SharedPrefController()
        .getValueFor<String>(key: PrefKeys.token.name)!
  };
}
