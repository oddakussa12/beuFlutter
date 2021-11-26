import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:origin/origin.dart';

import 'ball_spin_fade_loader_indicator.dart';
import 'classics_empty_widget.dart';
import 'classics_loading_widget.dart';

/**
 * empty_widget.dart
 * 空布局
 * @author: Ruoyegz
 * @date: 2021/7/20
 */
class EmptyWidget extends StatefulWidget {
  /// 自定义的空视图
  Widget? empty;

  /// 自定义的加载中视图
  final Widget? loading;

  /// 空状态
  final EmptyStatus? state;

  /// 布局的 Margin
  final EdgeInsetsGeometry? margin;

  /// 布局的对齐方式
  final AlignmentGeometry? alignment;

  EmptyWidget(
      {Key? key,
      this.state = EmptyStatus.Normal,
      this.empty,
      this.loading,
      this.margin,
      this.alignment})
      : super(key: key);

  EmptyWidget.classics({
    Key? key,
    this.state = EmptyStatus.Loading,
    String? emptyIcon ,
    bool? showEmptyIcon = false,
    String? emptyMessage,
    String? emptyOption,
    bool? showEmptyOption = false,
    GestureTapCallback? onTapEmpty,
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.all(16),
  })  :

        /// 内置的空视图
        this.empty = ClassicsEmptyWidget(
          icon: emptyIcon,
          message: emptyMessage,
          option: emptyOption,
          showIcon: TextHelper.isEmpty(emptyIcon) ? false : showEmptyIcon,
          showOption: showEmptyOption,
          onTap: onTapEmpty,
        ),

        /// 内置的加载视图
        this.loading = ClassicsLoadingWidget(
          indicator: BallSpinFadeLoaderIndicator(),
          size: 48,
          color: AppColor.colorF7551D,
        ),
        super(key: key);

  @override
  _EmptyWidgetState createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: widget.margin,
            alignment: widget.alignment,

            /// 自定义布局 | 内置布局
            child: AnimatedCrossFade(
                alignment: Alignment.center,
                sizeCurve: Curves.bounceIn,
                duration: Duration(microseconds: 3),
                firstChild: widget.loading!,
                secondChild: widget.empty!,
                crossFadeState: widget.state == EmptyStatus.Loading
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond)));
  }
}
