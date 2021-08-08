import 'package:common/src/widget/progress_bar_icon.dart';
import 'package:flutter/material.dart';

enum ButtonStatus { idle, loading, success, fail }

/**
 * ProgressbarButton
 * 进度按钮
 * @author: Ruoyegz
 * @date: 2021/8/8
 */
class ProgressbarButton extends StatefulWidget {
  final radius;
  final height;
  final minWidth;
  final maxWidth;

  /// 进度指示器尺寸
  final indicatorSize;

  final EdgeInsets padding;

  /// 回调
  final Function? onPressed;
  final Function? onAnimationEnd;

  final ButtonStatus? status;

  final ProgressIndicator? progressIndicator;

  /// Widget 集合
  final Map<ButtonStatus, Widget> statusWidgets;
  final Map<ButtonStatus, Color> statusColors;
  final List<ButtonStatus> minWidthStates;

  /// 指示器对齐方式
  final MainAxisAlignment indicatorAlignment;

  const ProgressbarButton(
      {Key? key,
      required this.statusWidgets,
      required this.statusColors,
      this.status = ButtonStatus.idle,
      this.onPressed,
      this.onAnimationEnd,
      this.minWidth = 200.0,
      this.maxWidth = 400.0,
      this.radius = 16.0,
      this.height = 53.0,
      this.indicatorSize = 35.0,
      this.progressIndicator,
      this.indicatorAlignment = MainAxisAlignment.spaceBetween,
      this.padding = EdgeInsets.zero,
      this.minWidthStates = const <ButtonStatus>[ButtonStatus.loading]})
      : /*assert(
          statusWidgets != null && statusWidgets.keys.toSet().containsAll(ButtonStatus.values.toSet()),
          'Must be non-null widgets provided in map of stateWidgets. Missing keys',
        ),*/
        /*assert(
          statusColors != null &&
              statusColors.keys
                  .toSet()
                  .containsAll(ButtonStatus.values.toSet()),
          'Must be non-null widgets provided in map of stateWidgets. Missing keys',
        ),*/
        super(key: key);

  @override
  _ProgressbarButtonState createState() => _ProgressbarButtonState();

  factory ProgressbarButton.icon({
    required Map<ButtonStatus, ProgressbarIcon> barIcons,
    ButtonStatus? status = ButtonStatus.idle,
    Function? onPressed,
    Function? animationEnd,
    maxWidth: 170.0,
    minWidth: 58.0,
    height: 53.0,
    radius: 100.0,
    indicatorSize: 35.0,
    double iconPadding: 4.0,
    TextStyle? textStyle,
    CircularProgressIndicator? indicator,
    MainAxisAlignment? progressIndicatorAligment,
    EdgeInsets padding = EdgeInsets.zero,
    List<ButtonStatus> minWidthStates = const <ButtonStatus>[
      ButtonStatus.loading
    ],
  }) {
    assert(
      barIcons != null &&
          barIcons.keys.toSet().containsAll(ButtonStatus.values.toSet()),
      'Must be non-null widgets provided in map of stateWidgets. Missing keys => ${ButtonStatus.values.toSet().difference(barIcons.keys.toSet())}',
    );

    if (textStyle == null) {
      textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500);
    }

    Map<ButtonStatus, Widget> stateWidgets = {
      ButtonStatus.idle: buildChildWithIcon(
          barIcons[ButtonStatus.idle]!, iconPadding, textStyle),
      ButtonStatus.loading: Column(),
      ButtonStatus.fail: buildChildWithIcon(
          barIcons[ButtonStatus.fail]!, iconPadding, textStyle),
      ButtonStatus.success: buildChildWithIcon(
          barIcons[ButtonStatus.success]!, iconPadding, textStyle)
    };

    Map<ButtonStatus, Color> stateColors = {
      ButtonStatus.idle: barIcons[ButtonStatus.idle]!.color,
      ButtonStatus.loading: barIcons[ButtonStatus.loading]!.color,
      ButtonStatus.fail: barIcons[ButtonStatus.fail]!.color,
      ButtonStatus.success: barIcons[ButtonStatus.success]!.color,
    };

    return ProgressbarButton(
      statusWidgets: stateWidgets,
      statusColors: stateColors,
      status: status,
      onPressed: onPressed,
      onAnimationEnd: animationEnd,
      maxWidth: maxWidth,
      minWidth: minWidth,
      radius: radius,
      height: height,
      indicatorSize: indicatorSize,
      indicatorAlignment: MainAxisAlignment.center,
      progressIndicator: indicator,
      minWidthStates: minWidthStates,
    );
  }
}

class _ProgressbarButtonState extends State<ProgressbarButton>
    with TickerProviderStateMixin {
  AnimationController? colorAnimationController;
  Animation<Color?>? colorAnimation;
  double? width;
  Duration animationDuration = Duration(milliseconds: 500);
  Widget? progressIndicator;

  void startAnimations(ButtonStatus? oldState, ButtonStatus? newState) {
    Color? begin = widget.statusColors[oldState!];
    Color? end = widget.statusColors[newState!];
    if (widget.minWidthStates.contains(newState)) {
      width = widget.minWidth;
    } else {
      width = widget.maxWidth;
    }
    colorAnimation = ColorTween(begin: begin, end: end).animate(CurvedAnimation(
      parent: colorAnimationController!,
      curve: Interval(
        0,
        1,
        curve: Curves.easeIn,
      ),
    ));
    colorAnimationController!.forward();
  }

  Color? get backgroundColor => colorAnimation == null
      ? widget.statusColors[widget.status!]
      : colorAnimation!.value ?? widget.statusColors[widget.status!];

  @override
  void initState() {
    super.initState();

    width = widget.maxWidth;

    colorAnimationController =
        AnimationController(duration: animationDuration, vsync: this);
    colorAnimationController!.addStatusListener((status) {
      if (widget.onAnimationEnd != null) {
        widget.onAnimationEnd!(status, widget.status);
      }
    });

    progressIndicator = widget.progressIndicator ??
        CircularProgressIndicator(
            backgroundColor: widget.statusColors[widget.status!],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
  }

  @override
  void dispose() {
    colorAnimationController!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProgressbarButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.status != widget.status) {
      colorAnimationController?.reset();
      startAnimations(oldWidget.status, widget.status);
    }
  }

  Widget getButtonChild(bool visibility) {
    Widget? buttonChild = widget.statusWidgets[widget.status!];
    if (widget.status == ButtonStatus.loading) {
      return Row(
        mainAxisAlignment: widget.indicatorAlignment,
        children: <Widget>[
          SizedBox(
            child: progressIndicator,
            width: widget.indicatorSize,
            height: widget.indicatorSize,
          ),
          buttonChild ?? Container(),
          Container()
        ],
      );
    }
    return AnimatedOpacity(
        opacity: visibility ? 1.0 : 0.0,
        duration: Duration(milliseconds: 250),
        child: buttonChild);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimationController!,
      builder: (context, child) {
        return AnimatedContainer(
            width: width,
            height: widget.height,
            duration: animationDuration,
            child: MaterialButton(
              padding: widget.padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(color: Colors.transparent, width: 0)),
              color: backgroundColor,
              onPressed: widget.onPressed as void Function()?,
              child: getButtonChild(
                  colorAnimation == null ? true : colorAnimation!.isCompleted),
            ));
      },
    );
  }
}
