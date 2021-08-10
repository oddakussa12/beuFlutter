import 'package:origin/origin.dart';

import '../global_share.dart';

class ValueFormat {
  static String formatDouble(double? value) {
    return format.format(value == null ? 0.0 : value);
  }

  static double cleanDouble(double? value, {double? def}) {
    return value == null ? (def != null ? def : 0.0) : value;
  }

  static double parseDouble(String? value) {
    try {
      return double.parse(value ?? "");
    } on Error catch (e) {
      LogDog.w("parseDouble, error: ${value}");
      return 0.0;
    }
  }
}
