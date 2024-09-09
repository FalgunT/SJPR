import 'dart:async';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:sjpr/common/common_toast.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:flutter/material.dart';

import '../../model/api_response_otprequest.dart';
import '../dashboard/dashboard.dart';

class LoginBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

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

  Future forget(BuildContext context, bool mounted) async {
    var loginResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .newPassword(
            pass: passwordController.text,
            confirmpass: confirmpasswordController.text,
            id: apiOTP!.data.id);
    if (!mounted) return;
    if (loginResponse != null) {
      CommonToast.getInstance()
          ?.displayToast(bContext: context, message: loginResponse.message!);
      return loginResponse.status;
    }
    return false;
  }

  OtpResponse? apiOTP;

  Future sendOTP(BuildContext context, bool mounted) async {
    apiOTP = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .sendOTP(email: emailController.text);
    if (!mounted) return;
    if (apiOTP != null) {
      debugPrint('OTP Response--->${apiOTP.toString()}');
      CommonToast.getInstance()
          ?.displayToast(bContext: context, message: apiOTP!.message);
      return apiOTP?.status;
    }
    return false;
  }

  Future<bool> localOTPValidate() async {
    debugPrint('Api OTP--->${apiOTP?.data.otp.toString()}');
    debugPrint('Input OTP--->${otpController.text}');
    if (apiOTP?.data.otp.toString().trim() == otpController.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  void initData() {
    // TODO: implement initData
    super.initData();
    /* emailController.text = 'falguntanwar@virtualemployee.com';
    passwordController.text = '123456789@';*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
