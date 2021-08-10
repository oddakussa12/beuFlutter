import 'package:origin/origin.dart';

class SentryHelper {
  static Future<SentryId> caught(dynamic throwable,
      {dynamic stackTrace, dynamic hint, ScopeCallback? withScope}) async {
    LogDog.w("SentryHelper-caught: ${throwable}");
    return await Sentry.captureException(throwable, stackTrace: stackTrace);
  }
}
