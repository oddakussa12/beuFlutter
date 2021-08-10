void main() {
  print(TextHelper.isAllEmpty(["", "", ""]));

  print(TextHelper.isAnyNotEmpty(["", "", ""]));

  print(TextHelper.isAnyEmpty(["122334", "123", "2344"]));

  print("clean: " + TextHelper.cleanFirst([null, "", "2344"]));
}

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

  static bool isAllEmpty(List<String?> targets) {
    return !targets.any((element) => isNotEmpty(element));
  }

  static bool isAnyEmpty(List<String?> targets) {
    return targets.any((element) => isEmpty(element));
  }

  static bool isAnyNotEmpty(List<String?> targets) {
    return targets.any((element) => isNotEmpty(element));
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

  static String cleanFirst(List<String?> targets) {
    return targets.firstWhere((element) => isNotEmpty(element),
            orElse: () => "") ??
        "";
  }
}
