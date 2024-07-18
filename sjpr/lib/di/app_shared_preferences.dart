import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  //static const deviceId = 'device_id';
  static const token = 'token';

  //static const profile = 'profile';

  Future<SharedPreferences> initPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool?> clearDataOnLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }

  Future getUserDetail({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }


  Future setUserDetail({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
