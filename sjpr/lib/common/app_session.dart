import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
      clearCache();
      Navigator.of(context).popUntil((route) => false);
      Future.delayed(const Duration(milliseconds: 50),(){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                token: '',
              )),
        );
      });

    } catch (e) {
      print(e);
    }
  }

  Future<void> clearCache() async {
    try {
      // Get the cache directory
      final cacheDir = await getTemporaryDirectory();

      // Check if the directory exists
      if (cacheDir.existsSync()) {
        // Delete the cache directory and all its contents
        cacheDir.deleteSync(recursive: true);
        print('Cache cleared.');
      } else {
        print('Cache directory does not exist.');
      }
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  Future<bool> deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        print('File deleted: $path');
        return true;
      } else {
        print('File not found: $path');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
