import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'classics_loading_indicator.dart';

/**
 * classics_loading_widget.dart
 * 经典的加载视图
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class ClassicsLoadingWidget extends StatefulWidget {

  double size;
  Color color;
  final LoadingIndicator indicator;

  ClassicsLoadingWidget(
      {Key? key,
      required this.indicator,
      this.size = 50.0,
      this.color = Colors.white})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClassicsLoadingState(indicator, size);
  }
}

class ClassicsLoadingState extends State<ClassicsLoadingWidget>
    with TickerProviderStateMixin {
  LoadingIndicator indicator;
  double size;

  ClassicsLoadingState(this.indicator, this.size);

  @override
  void initState() {
    super.initState();
    indicator.context = this;
    indicator.start();
  }

  @override
  void dispose() {
    indicator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClassicsPainter(indicator, widget.color),
      size: Size.square(size),
    );
  }
}

class _ClassicsPainter extends CustomPainter {
  LoadingIndicator indicator;
  Color color;
  late Paint defaultPaint;

  _ClassicsPainter(this.indicator, this.color) {
    defaultPaint = Paint()
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.fill
      ..color = color
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    indicator.paint(canvas, defaultPaint, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
