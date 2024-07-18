import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxrun/common/curved_background.dart';
import 'package:taxrun/common/string_utils.dart';
import 'package:taxrun/common/yellow_button.dart';
import 'package:taxrun/screen/login/new_password_page.dart';
import 'package:taxrun/screen/login/newpw_bloc.dart';

import 'forgotpw_bloc.dart';

class ForgotPw extends StatefulWidget {
  final ForgotPwBloc forgotPwBloc;

  const ForgotPw({Key? key, required this.forgotPwBloc}) : super(key: key);

  @override
  State<ForgotPw> createState() => _ForgotPwState();
}

class _ForgotPwState extends State<ForgotPw> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      borderSide: BorderSide.none,
    );
    return CurvedBackground(
        title: StringUtils.forgotPw,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                stream: widget.forgotPwBloc.usernameStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    onChanged: widget.forgotPwBloc.usernameSink.add,
                    decoration: InputDecoration(
                      focusedBorder: border,
                      border: border,
                      fillColor: const Color.fromRGBO(
                          255, 255, 255, 0.3499999940395355),
                      filled: true,
                      labelStyle: TextStyle(
                        color: HexColor("1F1E1E"),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                      labelText: StringUtils.enterPhoneNo,
                      prefixIcon: const Icon(
                        Icons.phone_android_sharp,
                      ),
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : "",
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              YellowButton(
                //onPressed: () => forgotPwBloc.loginSink.add,
                onPressed: () {
                  _showMyDialog(context);
                },
                content: StringUtils.resetPw,
                isEnabled: true,
              ),
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //shape: ShapeBorder,
          backgroundColor: HexColor("#B6F5EE"),
          title: const Center(
            child: Text(
              "Check your message",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  /* const Text(
                    "Check your message",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            'We have send a verification code OTP to your number ',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.grey.shade600)),
                    TextSpan(
                        text: ' +2035382636252',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey.shade900))
                  ])),
                  const SizedBox(
                    height: 50,
                  ),
                  PinCodeTextField(
                    controller: pinController,
                    textStyle: const TextStyle(color: Colors.grey),
                    appContext: context,
                    length: 4,
                    obscureText: true,
                    obscuringCharacter: '*',
                    enableActiveFill: true,
                    pinTheme: PinTheme(
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.grey.shade500,
                        //const Color(0xFFF0F0F3),
                        activeColor: Colors.grey.shade500,
                        //const Color(0xFFF0F0F3),
                        inactiveColor: Colors.grey.shade500,
                        //const Color(0xFFF0F0F3),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        activeBoxShadow: [
                          const BoxShadow(
                              offset: Offset(2, 2),
                              color: Color(0xFFF0F0F3),
                              blurRadius: 10,
                              spreadRadius: 2)
                        ],
                        inActiveBoxShadow: [
                          const BoxShadow(
                              offset: Offset(2, 2),
                              color: Color(0xFFF0F0F3),
                              blurRadius: 10,
                              spreadRadius: 2)
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: YellowButton(
                      isEnabled: true,
                      content: 'Verify',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewPw(newPwBloc: NewPwBloc())),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Didn\'t get OTP ',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.grey.shade900)),
                    TextSpan(
                        text: ' Resend?',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor("#E41818")))
                  ])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          /*  actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],*/
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pinController.dispose();
    super.dispose();
  }
}
