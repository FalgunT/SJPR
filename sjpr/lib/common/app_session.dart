import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../di/app_shared_preferences.dart';
import '../di/shared_preferences.dart';
import '../main.dart';

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
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } catch (e) {
      print(e);
    }
  }
}
