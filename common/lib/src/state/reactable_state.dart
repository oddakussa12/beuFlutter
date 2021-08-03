import 'package:common/common.dart';
import 'package:common/src/architecture/react_actuator.dart';
import 'package:flutter/material.dart';

import '../architecture/architecture.dart';
import '../architecture/retry_actuator.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.attach(context, this);
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
}
