import 'dart:async';
import 'dart:convert';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:flutter/material.dart';

class ClientAreaBloc extends BlocBase {
  static ClientAreaBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  static ClientAreaBloc getInstance() {
    _instance ??= ClientAreaBloc();
    return _instance!;
  }

  Future getDashboard(BuildContext context) async {
    /* if (await AppComponentBase.getInstance()
        ?.getNetworkManager()
        .isConnected() ??
        false) {
      var getDashboard = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .getDashboard(id: 'pospId',isProgressBar: false);
      if (getDashboard != null &&
          getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
        //await getProfile(pospId);
      }
    }
    else {
      var dashboard = await AppComponentBase.getInstance()
          ?.getSharedPreference()
          .getUserDetail(key: SharedPreference().dashboard);
      var getDashboard = GetDashboard.fromJson(json.decode(dashboard));
      if (getDashboard.resultflag == ApiClient.resultflagSuccess &&
          getDashboard.data != null) {
        dashboardStreamController.sink.add(getDashboard.data!);
      }
    }*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
