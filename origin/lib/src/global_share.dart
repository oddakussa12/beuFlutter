import 'package:intl/intl.dart';
import 'package:origin/origin.dart';

/// 全局共享数据格式化
NumberFormat format = new NumberFormat("0.00");

/// 全局通用的动作回调函数【可以用于各种无参动作的回调】
typedef Actioned = void Function();

/// 全局通用状态动作回调函数
typedef StatusAction = void Function(int status);

/// 等待返回
typedef WaitingReturn<T> = bool Function();

/// 全局通用的成功回调函数【可以用于各种一参动作的回调】
typedef Success<T> = void Function(T result);

/// 全局通用的失败回调函数
typedef Failure = void Function(String message, Exception e);

/// 全局通用的完成回调函数
typedef Complete = void Function();

/// 全局通用的错误回调函数
typedef OnError = void Function({Error e});

/// 全局通用的状态改变回调函数
typedef StateChanged = void Function(int state);
