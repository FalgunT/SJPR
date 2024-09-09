import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sjpr/common/app_session.dart';
import 'package:sjpr/common/custom_progress.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:sjpr/di/app_shared_preferences.dart';
import 'package:sjpr/screen/auth/login_screen.dart';
import 'package:sjpr/screen/dashboard/dashboard.dart';
import 'package:sjpr/services/api_client.dart';

//late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    AppSession.getInstance()?.clearCache();
  } catch (e) {
    print(e);
  }
  AppComponentBase.getInstance()?.initialiseNetworkManager();
  //cameras = await availableCameras();
  var token = await AppComponentBase.getInstance()
      ?.getSharedPreference()
      .getUserDetail(key: AppSharedPreference.token);
  if (token != null) ApiClient.logoutHeaderValue = token;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(token: token));
  });
}

class MyApp extends StatefulWidget {
  String? token;
  MyApp({super.key, @required this.token});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFBA9E2E)),
        useMaterial3: true,
      ),
      home: (widget.token == null || widget.token!.isEmpty)
          ? const LoginScreen()
          : const Dashboard(),
      builder: (context, widget) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              StreamBuilder<bool>(
                  initialData: false,
                  stream: AppComponentBase.getInstance()?.disableWidgetStream,
                  builder: (context, snapshot) {
                    return IgnorePointer(
                        ignoring: snapshot.data ?? false,
                        child: NotificationListener<
                                OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: widget ?? Container()));
                  }),
              StreamBuilder<bool>(
                  initialData: false,
                  stream: AppComponentBase.getInstance()?.progressDialogStream,
                  builder: (context, snapshot) {
                    return (snapshot.data ?? false)
                        ? const Center(child: CustomProgressDialog())
                        : const Offstage();
                  })
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    AppComponentBase.getInstance()?.getNetworkManager().disposeStream();
    AppComponentBase.getInstance()?.dispose();
    super.dispose();
  }
}
