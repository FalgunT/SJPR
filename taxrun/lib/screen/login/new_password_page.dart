import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taxrun/common/string_utils.dart';
import 'package:taxrun/common/yellow_button.dart';
import 'package:taxrun/screen/login/newpw_bloc.dart';

import '../../common/curved_background.dart';

class NewPw extends StatelessWidget {
  final NewPwBloc newPwBloc;

  const NewPw({Key? key, required this.newPwBloc}) : super(key: key);

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
        title: StringUtils.newPw,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder<String>(
                    stream: newPwBloc.usernameStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        onChanged: newPwBloc.usernameSink.add,
                        decoration: InputDecoration(
                          focusedBorder: border,
                          border: border,
                          fillColor: const Color.fromRGBO(
                              255, 255, 255, 0.3499999940395355),
                          filled: true,
                          labelStyle: TextStyle(color: HexColor("1F1E1E")),
                          labelText: StringUtils.newPw,
                          prefixIcon: const Icon(Icons.lock),
                          errorText: snapshot.error != null
                              ? snapshot.error.toString()
                              : "",
                        ),
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  StreamBuilder<String>(
                    stream: newPwBloc.passwordStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        onChanged: newPwBloc.passwordSink.add,
                        decoration: InputDecoration(
                          focusedBorder: border,
                          border: border,
                          fillColor: const Color.fromRGBO(
                              255, 255, 255, 0.3499999940395355),
                          filled: true,
                          labelStyle: TextStyle(color: HexColor("1F1E1E")),
                          labelText: StringUtils.confirmPw,
                          prefixIcon: const Icon(Icons.lock),
                          errorText: snapshot.error != null
                              ? snapshot.error.toString()
                              : "",
                        ),
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  YellowButton(
                    onPressed: () => newPwBloc.loginSink.add,
                    content: StringUtils.submit,
                    isEnabled: true,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
