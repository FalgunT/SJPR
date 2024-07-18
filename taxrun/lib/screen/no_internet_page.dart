import 'package:flutter/material.dart';
import 'package:taxrun/common/app_theme.dart';
import 'package:taxrun/common/string_utils.dart';
import 'package:taxrun/common/yellow_button.dart';

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage>
    with TickerProviderStateMixin {
  //final LoginSendOTPBloc bloc = LoginSendOTPBloc();

  @override
  void initState() {
    super.initState();
    // bloc.getURLs(context);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          onBack();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                StringUtils.noInternet,
                textAlign: TextAlign.left,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              elevation: 0,
              // give the app bar rounded corners
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      onBack();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                  );
                },
              )),
          body: LayoutBuilder(builder: (context, constraint) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      /*  SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: SvgPicture.asset(
                          SvgImages.noInternet,
                          //color: appTheme.primaryColor,
                        ),
                      ),*/
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(StringUtils.noInternet,
                          style: TextStyle(
                              color: appTheme.primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(72, 24, 72, 24),
                        child: Text(StringUtils.noInternetContent,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 12.0),
                      child: YellowButton(
                        isEnabled: true,
                        content: StringUtils.tryAgain,
                        onPressed: () async {
                          /*final form = sendOTPKey.currentState;
                          if (form?.validate() ?? false) {
                            form?.save();
                            bloc.sendOTP(context);
                          }*/
                        },
                      )),
                ]);
          }),
          /*StreamBuilder(
            stream: _bloc.mainStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container();
            },
          ),*/
        ),
      ),
    );
  }

  void onBack() {
    Navigator.pop(context);
  }
}
