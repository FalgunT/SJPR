import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/screen/auth/login_bloc.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/common_number_filed.dart';
import 'package:sjpr/widgets/common_text_filed.dart';

import '../../common/common_toast.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
GlobalKey<FormState> formforgetKey = GlobalKey<FormState>();
GlobalKey<FormState> formOTPKey = GlobalKey<FormState>();
GlobalKey<FormState> formforgetDetailKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = LoginBloc();
    loginBloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.backGroundColor,
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  'lib/assets/login_bg_image.png',
                  fit: BoxFit.contain,
                ),
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        Color.fromRGBO(0, 0, 0, 55),
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to\nSJPR!',
                          style: TextStyle(
                            color: appTheme.activeTxtColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Image.asset("lib/assets/logo.png")
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Center(
                      child: Text(
                        'Login to your account',
                        style: TextStyle(
                          color: appTheme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Center(
                      child: CommonButton(
                        content: "Login",
                        bgColor: appTheme.buttonBgColor,
                        textColor: appTheme.buttonTextColor,
                        outlinedBorderColor: appTheme.buttonBgColor,
                        onPressed: () {
                          bottomSheet();
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          showForgetBottomSheet();
                        },
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                              decorationColor: appTheme.activeTxtColor,
                              decoration: TextDecoration.underline,
                              color: appTheme.activeTxtColor,
                              fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showForgetBottomSheet() {
    final appTheme = AppTheme.of(context);
    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        isDismissible: false,
        // Prevents tapping outside to dismiss
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          final bottom = EdgeInsets.fromViewPadding(
                  WidgetsBinding.instance.window.viewInsets,
                  WidgetsBinding.instance.window.devicePixelRatio)
              .bottom;
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottom),
                /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */
                // Add bottom padding to avoid keyboard overlap
                child: Form(
                  key: formforgetKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                  color: appTheme.textColor, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: appTheme.textColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: loginBloc.emailController,
                        hintText: "Enter your email address",
                        validation: (String? val) {
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(val!)) {
                            return 'This Email Format is not valid.';
                          }
                          if (val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          content: "Submit",
                          bgColor: appTheme.buttonBgColor,
                          textColor: appTheme.buttonTextColor,
                          outlinedBorderColor: appTheme.buttonBgColor,
                          onPressed: () async {
                            if (formforgetKey.currentState!.validate()) {
                              var res = await loginBloc.sendOTP(context, true);
                              //show otp screen
                              Navigator.pop(context);
                              showOTPSheet();
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Please enter a valid email address. An OTP will be sent to this email address for verification.",
                        style: TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  showOTPSheet() {
    final appTheme = AppTheme.of(context);
    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        isDismissible: false,
        // Prevents tapping outside to dismiss
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          final bottom = EdgeInsets.fromViewPadding(
                  WidgetsBinding.instance.window.viewInsets,
                  WidgetsBinding.instance.window.devicePixelRatio)
              .bottom;
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottom),
                /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */
                // Add bottom padding to avoid keyboard overlap
                child: Form(
                  key: formOTPKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Enter OTP",
                              style: TextStyle(
                                  color: appTheme.textColor, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: appTheme.textColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonNumberField(
                        controller: loginBloc.otpController,
                        hintText: "Enter your OTP",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          content: "Validate",
                          bgColor: appTheme.buttonBgColor,
                          textColor: appTheme.buttonTextColor,
                          outlinedBorderColor: appTheme.buttonBgColor,
                          onPressed: () async {
                            if (formOTPKey.currentState!.validate()) {
                              bool res = await loginBloc.localOTPValidate();
                              if (res) {
                                Navigator.pop(context);
                                showNewPasswordSheet();
                              } else {
                                CommonToast.getInstance()?.displayToast(
                                    bContext: context,
                                    message: "Verification failed!");
                              }
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  showNewPasswordSheet() {
    final appTheme = AppTheme.of(context);

    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        isDismissible: false,
        // Prevents tapping outside to dismiss
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          final bottom = EdgeInsets.fromViewPadding(
                  WidgetsBinding.instance.window.viewInsets,
                  WidgetsBinding.instance.window.devicePixelRatio)
              .bottom;
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottom),
                /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */
                // Add bottom padding to avoid keyboard overlap
                child: Form(
                  key: formforgetDetailKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Set new password",
                              style: TextStyle(
                                  color: appTheme.textColor, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: appTheme.textColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: loginBloc.passwordController,
                        hintText: "New password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: loginBloc.confirmpasswordController,
                        hintText: "Confirm password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          content: "Submit",
                          bgColor: appTheme.buttonBgColor,
                          textColor: appTheme.buttonTextColor,
                          outlinedBorderColor: appTheme.buttonBgColor,
                          onPressed: () async {
                            if (formforgetDetailKey.currentState!.validate()) {
                              var res = await loginBloc.forget(context, true);
                              if (res) {
                                Navigator.pop(context);
                              }
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  bottomSheet() {
    final appTheme = AppTheme.of(context);
    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          final bottom = EdgeInsets.fromViewPadding(
                  WidgetsBinding.instance.window.viewInsets,
                  WidgetsBinding.instance.window.devicePixelRatio)
              .bottom;
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottom),
                /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */
                // Add bottom padding to avoid keyboard overlap
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                  color: appTheme.textColor, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: appTheme.textColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: loginBloc.emailController,
                        hintText: "Enter your Email address",
                        validation: (String? val) {
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(val!)) {
                            return 'This Email Format is not valid.';
                          }
                          if (val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: loginBloc.passwordController,
                        hintText: "Enter your password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          content: "Login",
                          bgColor: appTheme.buttonBgColor,
                          textColor: appTheme.buttonTextColor,
                          outlinedBorderColor: appTheme.buttonBgColor,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              loginBloc.login(context, true);
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
