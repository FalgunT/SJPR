import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:taxrun/common/image_utils.dart';
import 'package:taxrun/common/string_utils.dart';
import 'package:taxrun/common/yellow_button.dart';
import 'package:taxrun/screen/login/forgotpw_bloc.dart';
import 'package:taxrun/screen/login/forgotpw_page.dart';

import '../../common/curved_background.dart';
import 'login_bloc.dart';

class LoginPage extends StatelessWidget {
  final LoginBloc loginBloc;

  const LoginPage({Key? key, required this.loginBloc}) : super(key: key);

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
        title: StringUtils.driverLogin,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //Add this CustomPaint widget to the Widget Tree
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Image.asset(AssetImages.imageLogo),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder<String>(
                  stream: loginBloc.usernameStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      onChanged: loginBloc.usernameSink.add,
                      decoration: InputDecoration(
                        focusedBorder: border,
                        border: border,
                        fillColor: const Color.fromRGBO(
                            255, 255, 255, 0.3499999940395355),
                        filled: true,
                        labelStyle: TextStyle(color: HexColor("1F1E1E")),
                        labelText: 'Username',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        errorText: snapshot.error != null
                            ? snapshot.error.toString()
                            : "",
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                StreamBuilder<String>(
                  stream: loginBloc.passwordStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      onChanged: loginBloc.passwordSink.add,
                      decoration: InputDecoration(
                        focusedBorder: border,
                        border: border,
                        fillColor: const Color.fromRGBO(
                            255, 255, 255, 0.3499999940395355),
                        filled: true,
                        labelStyle: TextStyle(color: HexColor("1F1E1E")),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
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
                  // onPressed: () => loginBloc.loginSink.add,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ForgotPw(forgotPwBloc: ForgotPwBloc())),
                    );
                  },
                  content: 'Sign in',
                  isEnabled: true,
                ),
              ],
            ),
          ),
        ));
  }
}
