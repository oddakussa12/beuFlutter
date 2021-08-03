import 'package:centre/src/pages/login_page.dart';
import 'package:centre/src/pages/user_centre_page.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppStatelessWidget(
      title: "Discover",
      builder: (BuildContext context) {
        return UserCentrePage();
      }));
}

