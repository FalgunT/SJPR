import 'dart:async';
import 'package:sjpr/common/app_session.dart';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/di/app_component_base.dart';
import 'package:sjpr/model/profile_model.dart';

class DashboardBloc extends BlocBase {
  static DashboardBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;
  StreamController<ProfileData?> profileStreamController =
      StreamController.broadcast();

  Stream<ProfileData?> get profileStream => profileStreamController.stream;

  static DashboardBloc getInstance() {
    _instance ??= DashboardBloc();
    return _instance!;
  }

  Future getProfile(BuildContext context, bool mounted) async {
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .profile();
      if (!mounted) return;
      if (getProfile != null) {
        if (getProfile.status == true) {
          profileStreamController.sink.add(getProfile.data);
        }
      }
    }
  }

  Future updateProfile(
      BuildContext context, bool mounted, String profilePath) async {
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .uploadProfilePic(profilePath: profilePath);
      if (!mounted) return;
      if (getProfile != null) {
        if (getProfile.status == true) {
          //profileStreamController.sink.add(getProfile.data);
        }
      }
    }
  }

  Future logout(BuildContext context, bool mounted) async {
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      var getProfile = await AppComponentBase.getInstance()
          ?.getApiInterface()
          .getApiRepository()
          .logout();
      if (!mounted) return;
      if (getProfile != null) {
        AppSession.getInstance()?.SessionEndEvent(context);
        //Navigator.of(context).re();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
