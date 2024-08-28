import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/screen/auth/login_bloc.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/widgets/common_text_filed.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                bottom: 59,
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
                          bottomSheet(context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    Center(
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                            decorationColor: appTheme.activeTxtColor,
                            decoration: TextDecoration.underline,
                            color: appTheme.activeTxtColor,
                            fontSize: 18),
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
}

bottomSheet(BuildContext context) {

  final appTheme = AppTheme.of(context);
  LoginBloc loginBloc = LoginBloc();
  loginBloc.initData();
  showModalBottomSheet(
      backgroundColor: appTheme.listTileBgColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 20, 20, 24),
              /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */ // Add bottom padding to avoid keyboard overlap
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
