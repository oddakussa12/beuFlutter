import 'package:app/src/app_routes.dart';
import 'package:app/src/pages/splash_page.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppStatelessWidget(
    builder: (BuildContext context) {
      return SplashPage();
    },
    title: 'beU',
    onGenerateRoute: (RouteSettings settings) {
      return AppRoutes.createRoute(settings);
    },
  ));
}
