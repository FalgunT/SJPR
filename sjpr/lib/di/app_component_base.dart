import 'dart:async';
import 'package:sjpr/di/api_interface.dart';
import 'package:sjpr/di/app_shared_preferences.dart';
import 'package:sjpr/di/network_manager.dart';

class AppComponentBase extends AppComponentBaseRepository {
  static AppComponentBase? _instance;
  final NetworkManager _networkManager = NetworkManager();
  final ApiInterface _apiInterface = ApiInterface();
  final AppSharedPreference _sharedPreference = AppSharedPreference();
  final StreamController<bool> _progressDialogStreamController =
      StreamController.broadcast();
  final StreamController<bool> _disableWidgetStreamController =
      StreamController.broadcast();
  Stream<bool> get progressDialogStream =>
      _progressDialogStreamController.stream;
  Stream<bool> get disableWidgetStream => _disableWidgetStreamController.stream;

  int _messageCount = 0;
  static AppComponentBase? getInstance() {
    _instance ??= AppComponentBase();
    return _instance;
  }

  setMessageCount(int count) {
    _messageCount = count;
  }

  int getMessageCount() {
    return _messageCount;
  }

  initialiseNetworkManager() async {
    await _networkManager.initialiseNetworkManager();
  }

  showProgressDialog(bool value) {
    _progressDialogStreamController.sink.add(value);
  }

  disableWidget(bool value) {
    _disableWidgetStreamController.sink.add(value);
  }

  dispose() {
    _progressDialogStreamController.close();
    _disableWidgetStreamController.close();
  }

  @override
  ApiInterface getApiInterface() {
    return _apiInterface;
  }

  @override
  AppSharedPreference getSharedPreference() {
    return _sharedPreference;
  }

  @override
  NetworkManager getNetworkManager() {
    return _networkManager;
  }
}

abstract class AppComponentBaseRepository {
  ApiInterface getApiInterface();

  AppSharedPreference getSharedPreference();

  NetworkManager getNetworkManager();
}
