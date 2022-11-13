import 'dart:convert';
import 'dart:io';

import 'package:hi_service/helpers/api_helper.dart';
import 'package:hi_service/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:hi_service/api/api_settings.dart';
import 'package:hi_service/models/api_response.dart';

import '../prefs/shared_pref_controller.dart';

enum EditRequstType { name, mobile, email }

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String email, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        User user = User.fromJson(json['data']);
       await SharedPrefController().save(user);
        return ApiResponse(json['message'], json['status']);
      } else if (response.statusCode == 400) {
        return ApiResponse(json['message'], false);
      }
    }
    return errorResponse;
  }

  Future<ApiResponse> register(User user) async {
    Uri uri = Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'name': user.name,
      'email': user.email,
      'mobile': user.mobile,
      'password': user.password,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ApiResponse(json['message'], true);
      } else if (response.statusCode == 400) {
        return ApiResponse(json['message'], false);
      }
    }
    return errorResponse;
  }

  Future<ApiResponse<String>> forgetPassword({required String email}) async {
    Uri uri = Uri.parse(ApiSettings.forget);
    var response = await http.post(uri, body: {
      'email': email,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        print(json['code']);
        return ApiResponse<String>(
            json['message'], true, json['code'].toString());
      }
      return ApiResponse(json['message'], false);
    }
    return ApiResponse('Somthing wrong', false);
  }

  Future<ApiResponse> resetPassword({required email,
      required code,
      required password,
      required confirmPassword}) async {
    Uri uri = Uri.parse(ApiSettings.reset);
    var response = await http.post(uri, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        // SharedPrefController().save(user);
        return ApiResponse(json['message'], true);
      }
      return ApiResponse(json['message'], false);
    }
    return errorResponse;
  }

  Future<ApiResponse> logout() async {
    String token =
        SharedPrefController().getValueFor<String>(key: PrefKeys.token.name)!;
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200 || response.statusCode == 401) {
      SharedPrefController().clear();
      return ApiResponse('Logged out successfully', true);
    }
    return errorResponse;
  }

  Future<ApiResponse> editProfile(
      {required String value, required EditRequstType editRequstType}) async {
    String token =
        SharedPrefController().getValueFor<String>(key: PrefKeys.token.name)!;
    Uri uri = Uri.parse(
      ApiSettings.edit.replaceFirst(
        '{name}',
        getEndPoint(editRequstType),
      ),
    );
    var response = await http.post(uri, body: {
      editRequstType.name: value,
    }, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
/*    print(value);
    print('*******************');
    print(uri);
    print('*******************');
    print(response.body);*/
    if (response.statusCode == 200 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // SharedPrefController().save(user);
        return ApiResponse(json['message'], true);
      }
      return ApiResponse(json['message'], false);
    }
    return errorResponse;
  }

  String getEndPoint(EditRequstType editRequstType) {
    switch (editRequstType) {
      case EditRequstType.name:
        return 'editName';
      case EditRequstType.mobile:
        // TODO: Handle this case.
        return 'editMobile';
      case EditRequstType.email:
        // TODO: Handle this case.
        return 'editEmail';
    }
  }

  Future<ApiResponse> changePassword(
      {required String password,
      required String newPassword,
      required String confirmNewPassword}) async {
    String token =
        SharedPrefController().getValueFor<String>(key: PrefKeys.token.name)!;

    Uri uri = Uri.parse(ApiSettings.changePassword);
    var response = await http.post(uri, body: {
      'password': password,
      'new_password': newPassword,
      'new_password_confirmation': confirmNewPassword,
    }, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var json = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return ApiResponse(json['message'], true);
      } else if (response.statusCode == 400) {
        return ApiResponse(json['message'], false);
      }
    }
    return errorResponse;
  }
}
