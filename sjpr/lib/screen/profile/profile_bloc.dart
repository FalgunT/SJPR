import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../common/bloc_provider.dart';
import '../../common/common_toast.dart';
import '../../di/app_component_base.dart';

class ProfileBloc extends BlocBase {
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  final TextEditingController oldpasswordController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmpasswordController =
      TextEditingController();

  Future ResetPassword(BuildContext context, bool mounted) async {
    var loginResponse = await AppComponentBase.getInstance()
        ?.getApiInterface()
        .getApiRepository()
        .passwordReset(
            oldPass: oldpasswordController.text,
            pass: passwordController.text,
            confirmpass: confirmpasswordController.text);
    if (!mounted) return;
    if (loginResponse != null) {
      CommonToast.getInstance()
          ?.displayToast(bContext: context, message: loginResponse.message!);
      return loginResponse.status;
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
