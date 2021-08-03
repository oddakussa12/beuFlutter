import 'dart:async';

import 'package:app/src/pages/home_page.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * splash_page.dart
 * 闪屏
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer downTimer;

  @override
  void initState() {
    super.initState();
    splashCountDown();
  }

  @override
  void dispose() {
    super.dispose();
    if (downTimer != null) {
      downTimer.cancel();
    }
  }

  void splashCountDown() async {
    downTimer = Timer(Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.push(context, PageTransition(type: TransitionType.rightToLeft, child:HomePage()));
    });
  }

  Future<bool> _requestWillPop() {
    Navigator.pop(context);
    Navigator.push(context, PageTransition(type: TransitionType.rightToLeft, child:HomePage()));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColor.colorF8,
        body: Container(
          alignment: Alignment.center,
          child: Image.asset(
            "res/images/ic_launcher.png",
            package: "resources",
            width: 96,
            height: 96,
          ),
        ),
      ),
      onWillPop: _requestWillPop,
    );
  }
}
