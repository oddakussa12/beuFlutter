import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/src/widget/shake/shake_type.dart';

/// 抖动动画效果的 Builder
class ShakeBuilder extends StatelessWidget {
  ///[child] 执行动画的组件
  ///[animation] 执行的动画
  ShakeBuilder(
      {required this.child,
      required this.animation,
      this.shakeScope = 5,
      this.shakeType = ShakeType.Rotate});

  ///执行动画的子Widget
  final Widget child;

  ///动画的定义
  final Animation<double> animation;

  ///抖动的类型
  final ShakeType shakeType;

  ///随机动画时使用构建随机数
  final Random random = Random();

  ///随机动画时抖动的波动范围
  final double shakeScope;

  @override
  Widget build(BuildContext context) {
    ///通过 AnimatedBuilder 组合动画
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return new Transform(

            ///构建Matrix4
            transform: buildMatrix4(),

            ///中心对齐
            alignment: Alignment.center,
            child: this.child);
      },
    );
  }

  ///根据不同的模式来构建不同的矩阵变化
  Matrix4 buildMatrix4() {
    if (shakeType == ShakeType.Rotate) {
      ///在XOY平面绕Z轴的旋转
      return Matrix4.rotationZ(animation.value);
    } else if (shakeType == ShakeType.Random) {
      ///随机使用旋转、上下平移、左右平移
      return buildRandowMatrix4();
    } else {
      double dx = 0;
      double dy = 0;
      if (shakeType == ShakeType.LeftRight) {
        ///X轴方向的平移
        dx = animation.value * 15;
      } else if (shakeType == ShakeType.TopBottom) {
        ///Y轴方向平移
        dy = animation.value * 15;
      } else {
        ///对齐线方向平移
        dx = animation.value * 15;
        dy = animation.value * 15;
      }

      print("dx $dx dy $dy");

      ///在XOY平面的平移
      return Matrix4.translationValues(dx, dy, 0);
    }
  }

  ///lib/demo/shake/shake_builder.dart
  ///构建随机变换的矩阵
  ///[animation.value]同时要适配旋转，
  ///[Matrix4]的旋转是使用弧度计算的，一般抖动使用 0.1左右的弧度微旋转即可
  ///所以这时配置的[animation.value]的取值范围建议使用 [-0.1,0.1]
  ///那么对于[Matrix4]的translationValues平移来讲是使用的逻辑像素
  ///   [-0.1,0.1]这个范围的变动对于平移无法有明显的抖动效果
  ///   所以在这里 对于平移来说使用的 [-1.5,1.5] 就会有明显一点的抖动效果
  ///[random.nextDouble()]这个方法的值范围为 [0.0-1.0]
  ///然后通过结合配置的[shakeScope]抖动的波动范围 默认为 5
  /// [Matrix4]平移范围为 [-1.5,6.5]
  Matrix4 buildRandowMatrix4() {
    ///随机数
    int nextRandom = random.nextInt(10);

    ///Matrix4矩阵偏移量
    double dx = 0;
    double dy = 0;
    if (nextRandom % 4 == 0) {
      ///左右平移
      dx = animation.value * 15 + shakeScope * random.nextDouble();
      return Matrix4.translationValues(dx, dy, 0);
    } else if (nextRandom % 4 == 1) {
      ///上下平移
      dy = animation.value * 15 + shakeScope * random.nextDouble();
      return Matrix4.translationValues(dx, dy, 0);
    } else if (nextRandom % 4 == 2) {
      ///对角线平移
      dx = animation.value * 15 + shakeScope * random.nextDouble();
      dy = animation.value * 15 + shakeScope * random.nextDouble();
      return Matrix4.translationValues(dx, dy, 0);
    } else {
      ///旋转
      return Matrix4.rotationZ(animation.value);
    }
  }
}
