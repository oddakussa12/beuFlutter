import 'package:common/common.dart';
import 'package:discover/src/pages/discover_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppStatelessWidget(
      title: "Discover",
      builder: (BuildContext context) {
        return DiscoverPage();
      }));
}
