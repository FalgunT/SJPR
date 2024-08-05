import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';

class LoginBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future login(BuildContext context, bool mounted) async {
    var loginResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .login(email: emailController.text, password: passwordController.text);
    if (!mounted) return;
    if (loginResponse != null) {
      if (loginResponse.status == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const Dashboard();
          }),
        );
      }
      CommonToast.getInstance()?.displayToast(
          bContext: context,
          message: loginResponse.message ??
              (loginResponse.status == true
                  ? "You logged in successfully"
                  : "Please try again later"));
    }
  }

  @override
  void initData() {
    // TODO: implement initData
    super.initData();
    emailController.text = 'falguntanwar@virtualemployee.com';
    passwordController.text = '123456789@';
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
