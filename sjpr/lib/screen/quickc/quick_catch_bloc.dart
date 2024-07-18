import 'dart:async';
import 'dart:convert';
import 'package:sjpr/common/bloc_provider.dart';
import 'package:flutter/material.dart';

class QuickCatchBloc extends BlocBase {
  static QuickCatchBloc? _instance;
  StreamController mainStreamController = StreamController.broadcast();

  Stream get mainStream => mainStreamController.stream;

  static QuickCatchBloc getInstance() {
    _instance ??= QuickCatchBloc();
    return _instance!;
  }

  Future getDashboard(BuildContext context) async {}

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
