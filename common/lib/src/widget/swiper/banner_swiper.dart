import 'dart:async';

import 'package:common/src/widget/swiper/banner_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(int index);

class BannerSwiper extends StatefulWidget {
  final double width;
  final double height;

  final Widget? normalWidget;
  final Widget? selectorWidget;
  final ItemWidgetBuilder builder;

  final int? length;

  bool autoLoop;
  bool showIndicator;
  final bool spaceMode;

  BannerSwiper(
      {Key? key,
      required this.width,
      required this.height,
      this.length = 0,
      required this.builder,
      this.selectorWidget,
      this.normalWidget,
      this.autoLoop = false,
      this.showIndicator = true,
      this.spaceMode = false});

  @override
  State<StatefulWidget> createState() {
    return _BannerSwiperState();
  }
}

class _BannerSwiperState extends State<BannerSwiper> {
  int bannerMax = 10000000000;

  double myWidth = 0;
  double viewportFractionCustom = 1;
  double paddingCustom = 0;

  int _currentIndex = 0;

  Timer? _timer;
  PageController? _pageController;
  late SquareIndicator squareIndicator;

  GlobalKey<SquareIndicatorState> indicatorKey =
      GlobalKey<SquareIndicatorState>();

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  //设置定时器
  _setTimer() {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      _pageController!.animateToPage(_currentIndex + 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.length! <= 0) {
      widget.showIndicator = false;
    }
    if (widget.spaceMode) {
      viewportFractionCustom = 0.925;
      paddingCustom = 0.0125;
    }

    myWidth = MediaQuery.of(context).size.width;
    if (widget.length! > 0 && _pageController == null) {
      _pageController = new PageController(
          initialPage: widget.length!,
          viewportFraction: viewportFractionCustom);
      _currentIndex = widget.length!;
      if (widget.autoLoop) {
        _setTimer();
      }
    }
    if (widget.length == 0) {
      return Container();
    }

    PageView pageView = new PageView.builder(
      itemBuilder: ((context, index) {
        GlobalKey _key = new GlobalKey();
        Container container = Container(
          key: _key,
          margin: EdgeInsets.only(
              left: myWidth * paddingCustom, right: myWidth * paddingCustom),
          width: myWidth,
          height: myWidth *
              (viewportFractionCustom - paddingCustom * 2) *
              widget.width /
              widget.height,
          child: widget.builder(index),
        );

        return container;
      }),
      itemCount: bannerMax,
      scrollDirection: Axis.horizontal,
      reverse: false,
      controller: _pageController,
      physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
      onPageChanged: ((index) {
        _currentIndex = index;
        if (indicatorKey.currentState != null) {
          indicatorKey.currentState!
              .updateWidgets(widget.length!, (_currentIndex) % widget.length!);
        } else {}
      }),
    );
    if (widget.showIndicator) {
      squareIndicator = SquareIndicator(
        normalWidget: widget.normalWidget,
        selectorWidget: widget.selectorWidget,
        key: indicatorKey,
        length: widget.length,
        select: (_currentIndex) % widget.length!,
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width *
          widget.width /
          widget.height *
          (viewportFractionCustom - paddingCustom * 2),
      child: Stack(
        children: <Widget>[pageView, _getSquareIndicator()],
      ),
    );
  }

  Widget _getSquareIndicator() {
    if (widget.showIndicator) {
      return Positioned(
        bottom: myWidth * 0.02,
        left: 0,
        right: 0,
        child: squareIndicator,
      );
    } else {
      return Container();
    }
  }
}
