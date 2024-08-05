import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/di/app_shared_preferences.dart';
import 'package:sjpr/main.dart';

class AppSession {
  static AppSession? _instance;
  static const logoutString = 'User Logged Out!';

  static AppSession? getInstance() {
    _instance ??= AppSession();
    return _instance;
  }

  void SessionEndEvent(BuildContext context) {
    try {
      AppSharedPreference().clearDataOnLogout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp(
                  token: '',
                )),
      );
    } catch (e) {
      print(e);
    }
  }
}
