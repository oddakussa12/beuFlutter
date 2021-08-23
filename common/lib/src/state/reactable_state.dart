import 'package:common/common.dart';
import 'package:common/src/architecture/react_actuator.dart';
import 'package:flutter/material.dart';

import '../architecture/architecture.dart';

/**
 * retryable state
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
abstract class ReactableState<A extends ReactActuator, T extends StatefulWidget>
    extends State<T> implements Viewer {
  final A actuator;

  ReactableState(this.actuator);

  @override
  void initState() {
    super.initState();
    LogDog.w(this.runtimeType.toString() + ", initState");

    actuator.attachViewer(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LogDog.w(this.runtimeType.toString() + ", didChangeDependencies");

    actuator.attachContext(context);
  }

  @override
  void dispose() {
    super.dispose();
    actuator.dispose();
  }

  @override
  void notifySetState([VoidCallback? callback]) {
    if (callback != null) {
      setState(callback);
    } else {
      setState(() {});
    }
  }

  @override
  void notifyToasty(String content) {
    toast(message: content);
  }

  @override
  void showLoading() {
    LoadingDialog.show(context);
  }

  @override
  void dismissLoading() {
    Navigator.pop(context);
  }
}
