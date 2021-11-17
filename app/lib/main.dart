import 'package:app/src/app_routes.dart';
import 'package:app/src/pages/splash_page.dart';
import 'package:centre/centre.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await SentryFlutter.init((options) {
    options.dsn = DioClient.SENTRY_DSN;
  },
      appRunner: () => runApp(
            ChangeNotifierProvider(
                create: (context) => SettingsModel(),
                child: AppStatelessWidget(
                  builder: (BuildContext context) {
                    return SplashPage();
                  },
                  title: 'beU Delivery',
                  onGenerateRoute: (RouteSettings settings) {
                    return AppRoutes.createRoute(settings);
                  },
                )),
          ));

  // Logger(printer: SimplePrinter(colors: true)).v('boom');
}
