import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:origin/origin.dart';

//// 事件回调
typedef EventCall<T> = void Function(T event);

/**
 * bus_client.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class BusClient {
  /// 单例
  static BusClient _instance = BusClient._internal();

  factory BusClient() => _instance;

  final EventBus bus = new EventBus();

  BusClient._internal() {}

  Stream<T> on<T>() {
    return bus.on();
  }

  StreamSubscription<T> subscribe<T>(EventCall<T>? call,
      {OnError? error, Complete? complete, bool? cancel}) {
    return bus
        .on<T>()
        .listen(call, onDone: complete, onError: error, cancelOnError: cancel);
  }

  void fire(event){
    bus.fire(event);
  }
}
