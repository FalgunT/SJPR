import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxrun/common/app_theme.dart';

class CommonToast {
  final AppThemeState _appTheme = AppThemeState();
  static CommonToast? _instance;

  static CommonToast? getInstance() {
    _instance ??= CommonToast();
    return _instance;
  }

  void displayToast({String message = ''}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        webShowClose: false,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: _appTheme.whiteColor,
        textColor: Colors.black,
        timeInSecForIosWeb: 2,
        fontSize: _appTheme.successToastTextSize);
  }
}
