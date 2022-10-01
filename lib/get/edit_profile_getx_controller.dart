import 'package:get/get.dart';
import 'package:hi_service/api/auth_api_controller.dart';
import 'package:hi_service/models/api_response.dart';
import '../models/user.dart';
import '../prefs/shared_pref_controller.dart';

class EditProfileGetxController extends GetxController {
  final AuthApiController authApiController = AuthApiController();

  static EditProfileGetxController get to =>
      Get.find<EditProfileGetxController>();
  User user = SharedPrefController().getUser();

  Future<ApiResponse> editProfile(
      {required String value, required EditRequstType editRequstType}) async {
    var response = await authApiController.editProfile(
        value: value, editRequstType: editRequstType);
    if (response.success) {
      _updateUser(editRequstType, value);
    }
    return response;
  }

//عرض البيانات مباشرة والتخزين في shared
  void _updateUser(EditRequstType editRequstType, String value) {
    if (editRequstType == EditRequstType.name) {
      user.name = value;
    } else if (editRequstType == EditRequstType.email) {
      user.email = value;
    } else {
      user.mobile = value;
    }
    SharedPrefController().save(user);
    update();
  }

  Future<ApiResponse> changPassword({
    required String password,
    required String newPassword,
    required String confirmNewPassword,
  }) async{
    return await authApiController.changePassword(password: password, newPassword: newPassword, confirmNewPassword: confirmNewPassword);
  }
}
