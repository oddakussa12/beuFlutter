import 'package:flutter/material.dart';

class SquareIndicator extends StatefulWidget {
  int? length;
  int? select;
  Widget? selectorWidget;
  Widget? normalWidget;

  SquareIndicator(
      {Key? key,
      this.length = 0,
      this.select = 0,
      this.selectorWidget,
      this.normalWidget})
      : super(key: key);
  SquareIndicatorState? indicator;

  @override
  State<StatefulWidget> createState() {
    if (indicator == null) {
      indicator = SquareIndicatorState();
    }
    return indicator!;
  }
}

class SquareIndicatorState extends State<SquareIndicator> {
  List<Widget> points() {
    List<Widget> list = [];
    for (var i = 0; i < widget.length!; i++) {
      list.add(_getWidget(i));
    }
    if (list.isEmpty) {
      list.add(Container());
    }
    return list;
  }

  Widget _getWidget(int i) {
    int index = widget.select!;
    if (index == i) {
      if (widget.selectorWidget != null) {
        return widget.selectorWidget!;
      }
      return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        width: 10,
        height: 4,
        color: Color.fromARGB(255, 153, 153, 153),
      );
    } else {
      if (widget.normalWidget != null) {
        return widget.normalWidget!;
      }
      return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        width: 10,
        height: 4,
        color: Color.fromARGB(255, 255, 255, 255),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: points(),
    );
  }

  updateWidgets(int length, int select) {
    widget.length = length;
    widget.select = select;
    setState(() {});
  }
}
