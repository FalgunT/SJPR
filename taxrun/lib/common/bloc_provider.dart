import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxrun/di/app_component_base.dart';

abstract class BlocBase {
  void dispose();

  void initData() {}
}

class BlocProvider<BlocBase> extends StatefulWidget {
  final Widget? child;
  final BlocBase? bloc;
  final Function? onInternetReConnected;

  const BlocProvider(
      {Key? key,
      @required this.child,
      @required this.bloc,
      this.onInternetReConnected})
      : super(key: key);

  static _BlocProviderInherited? of<BlocBase>(BuildContext context) {
    _BlocProviderInherited? provider =
        context.dependOnInheritedWidgetOfExactType();
    return provider;
  }

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState();
  }
}

class _BlocProviderState extends State<BlocProvider> {
  StreamSubscription<bool>? _streamSubscription;

  @override
  void initState() {
    widget.bloc?.initData();
    _streamSubscription = AppComponentBase.getInstance()
        ?.getNetworkManager()
        .internetConnectionStream
        .listen((isReConnected) {
      if (isReConnected && widget.onInternetReConnected != null) {
        widget.onInternetReConnected!();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(bloc: widget.bloc, child: widget.child);
  }

  @override
  void dispose() {
    widget.bloc?.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }
}

class _BlocProviderInherited extends InheritedWidget {
  final BlocBase? bloc;

  _BlocProviderInherited(
      {@required this.bloc, @required Widget? child, Key? key})
      : assert(child != null),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
