
import '../global_share.dart';

/**
 * text_helper.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/4
 */
class TextHelper {

  static bool isEmpty(String? text) {
    return text == null || text.length <= 0;
  }

  static bool isNotEmpty(String? text) {
    return text != null && text.length > 0;
  }

  static bool isEqual(String? front, String? after) {
    return front != null && front == after;
  }

  static String clean(String? text) {
    return text == null || text == "null" ? "" : text;
  }
}
