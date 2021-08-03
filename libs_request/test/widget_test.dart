// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:origin/origin.dart';

import 'package:request/request.dart';

/// 测试 url
final String TEST_BASE_URL = "https://test.api.helloo.mantouhealth.com";

void main() {
  DioClient().init(
      baseUrl: TEST_BASE_URL,
      appender: (options, handler) {
        options.headers["Authorization"] = "11111";
      });

  DioClient()
      .get("/api/user/86/15901230851/type/phone", (response) => response.data,
          success: (result) {
    LogDog.i("test-success: ${result}");
  }, fail: (message, e) {
    LogDog.i("test-fail: ${message} - ${e}");
  }, complete: () {
    LogDog.i("test-completed");
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});
}

void testDio() async {
  LogDog.i("start test");

  await DioClient()
      .get("/api/user/86/15901230851/type/phone", (response) => response.data,
          success: (result) {
    LogDog.i("test-success: ${result}");
  }, fail: (message, e) {
    LogDog.i("test-fail: ${message} - ${e}");
  }, complete: () {
    LogDog.i("test-completed");
  });
}
