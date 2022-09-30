
import 'package:hi_service/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { loggedIn, id, email, mobile, token, name, imageUrl }

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name,true);
    await _sharedPreferences.setInt(PrefKeys.id.name, user.id);
    await _sharedPreferences.setString(PrefKeys.email.name, user.email);
    await _sharedPreferences.setString(PrefKeys.name.name, user.name);
    await _sharedPreferences.setString(PrefKeys.mobile.name, user.mobile);
    await _sharedPreferences.setString(PrefKeys.imageUrl.name, "https://png.pngtree.com/element_our/png/20181206/users-vector-icon-png_260862.jpg");
    await _sharedPreferences.setString(PrefKeys.token.name, 'Bearer ${user.token}');
    print(_sharedPreferences.get(PrefKeys.token.name));
  }

  User getUser() {
    User user = User();
    user.id =  _sharedPreferences.getInt(PrefKeys.id.name)!;
    user.name =  _sharedPreferences.getString(PrefKeys.name.name)!;
    user.email =  _sharedPreferences.getString(PrefKeys.email.name)!;
    user.mobile =  _sharedPreferences.getString(PrefKeys.mobile.name)!;
    user.imageUrl =  _sharedPreferences.getString(PrefKeys.imageUrl.name);
    return user;
  }

  T? getValueFor<T>({required String key}) {
    print('shared');
    print('yahya ${_sharedPreferences.get(key)}');
    if(_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T?;
    }
    return null;
  }

  void clear() async {
    _sharedPreferences.clear();
  }
}
