import 'package:centre/centre.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shopping.dart';

/**
 * app_routes.dart
 * App 全局路由表
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class AppRoutes {
  /// 命名路由拦截器 | 在未配置路由表情况下可以用
  static Route<dynamic>? createRoute(RouteSettings settings) {
    LogDog.d("createRoute, settings-name: ${settings.name}");
    LogDog.d("createRoute, settings-arguments: ${settings.arguments}");

    if (Routes.common.WebPage == settings.name) {
      return PageTransition(
        child: BaseWebPage(),
        type: TransitionType.bottomToTop,
        settings: settings,
      );
    } else if (Routes.centre.Login == settings.name) {
      return PageTransition(
        child: LoginPage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    } else if (Routes.centre.Register == settings.name) {
      return PageTransition(
        child: RegisterStepOnePage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    } else if (Routes.shopping.ShopDetail == settings.name) {
      return PageTransition(
        child: ShopDetailPage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    } else if (Routes.shopping.ProductDetail == settings.name) {
      return PageTransition(
        child: ProductDetailPage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    } else if (Routes.shopping.OrderDetail == settings.name) {
      return PageTransition(
        child: OrderDetailPage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    }else if (Routes.shopping.OrderPreview == settings.name) {
      return PageTransition(
        child: OrderPreviewPage(),
        type: TransitionType.rightToLeft,
        settings: settings,
      );
    } else {}
  }
}
