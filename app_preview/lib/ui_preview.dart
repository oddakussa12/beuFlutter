import 'package:app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => AppStatelessWidget(
      builder: (BuildContext context) {
        return SplashPage();
      },
      title: 'beU',
      onGenerateRoute: (RouteSettings settings) {
        return AppRoutes.createRoute(settings);
      },
      locale: DevicePreview.locale(context),
      transitionBuilder: DevicePreview.appBuilder,
    ), // Wrap your app
  ));
}
