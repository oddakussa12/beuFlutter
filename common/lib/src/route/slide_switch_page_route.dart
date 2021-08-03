import 'package:flutter/material.dart';

/**
 * 滑动效果
 * @author: Ruoyegz
 * @date: 2021/7/6
 */
class SlideSwitchPageRoute extends PageRouteBuilder {
  final Widget widget;

  SlideSwitchPageRoute(this.widget)
      : super(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animation1,
                        curve: Curves.fastLinearToSlowEaseIn)),
                child: child,
              );
            });
}
