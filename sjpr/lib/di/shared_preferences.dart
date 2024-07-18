/*
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreference extends SharedPreferenceRepository {
  final String? deviceId = 'device_id';
  final String? token = 'token';
  final String? profile = 'profile';
  FlutterSecureStorage? storage;

  FlutterSecureStorage initPreference() {
    const options =
        IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    //await storage.write(key: key, value: value, iOptions: options);
    return const FlutterSecureStorage(iOptions: options);
  }

  @override
  Future getUserDetail({String? key}) async {
    storage ??= initPreference();
    // Read all values
    //Map<String, String> allValues = await storage!.readAll();
    String? value = await storage!.read(key: key ?? "");
    return value;
  }

  @override
  Future setUserDetail({String? key, String? value}) async {
    storage ??= initPreference();
    await storage!.write(key: key ?? "", value: value ?? "");
  }

  @override
  Future<bool?> clearData({String? key}) async {
    await storage!.delete(key: key ?? "");
    return true;
  }

  Future<bool?> clearDataOnLogout() async {
    storage ??= initPreference();
    await storage!.delete(key: token ?? "");
    await storage!.delete(key: profile ?? "");
    await storage!.deleteAll();
    return true;
  }
// Delete value

// Delete all
//await storage.deleteAll();
*/
/*
  SharedPreferences? _pref;

  @override
  Future getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  @override
  Future<bool?> clearData() async {
    _pref = await initPreference();
    _pref?.clear();
    return true;
  }

  Future<SharedPreferences> initPreference() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future setUserDetail() async {}

  Future saveDeviceId(String deviceId) async {
    SharedPreferences? pref = _pref;
    pref?.setString('theme', deviceId);
  }

  getDeviceId() async {
    var _deviceId = _pref!.reload().then((onValue) {
      return _pref?.getString('theme') ?? true;
    });
    //deviceId = await _deviceId;
  }*//*


*/
/*

  Future saveTheme() async{
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _light);
  }

  getTheme() async{

    var _lightF = _pref.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    });
    _theme = await _lightF;
  }
*//*

}

abstract class SharedPreferenceRepository {
  Future getUserDetail({String key});

  Future setUserDetail({String? key, String? value});

  Future<bool?> clearData({String key});
}
*/
