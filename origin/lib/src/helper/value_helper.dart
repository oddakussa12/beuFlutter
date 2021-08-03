
import '../global_share.dart';

class ValueFormat {

  static String formatDouble(double? value) {
    return format.format(value == null ? 0.0 : value);
  }
}