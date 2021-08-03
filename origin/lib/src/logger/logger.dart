
import 'package:logger/logger.dart';

import '../constants.dart';

/**
 * logger.dart
 * 日志
 * @author: Ruoyegz
 * @date: 2021/7/21
 */
class LogDog {
  static Logger _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: false,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Constants.isDebug || Constants.isDevelop) {
      _logger.d(message, error, stackTrace);
    }
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Constants.isDebug || Constants.isDevelop) {
      _logger.i(message, error, stackTrace);
    }
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Constants.isDebug || Constants.isDevelop) {
      _logger.w(message, error, stackTrace);
    }
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (Constants.isDebug) {
      _logger.e(message, error, stackTrace);
    }
  }
}
