import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:origin/origin.dart';

/**
 * classics_empty_widget.dart
 * 经典款空布局【默认】
 * @author: Ruoyegz
 * @date: 2021/7/22
 */
class ClassicsEmptyWidget extends StatefulWidget {
  /// 是否显示 ICON
  final bool? showIcon;

  /// 是否显示操作按钮
  final bool? showOption;

  /// icon path【asset】
  final String? icon;

  /// 提示信息
  final String? message;

  /// 操作按钮信息
  final String? option;

  /// 点击事件
  final GestureTapCallback? onTap;

  const ClassicsEmptyWidget({
    Key? key,
    this.icon,
    this.message,
    this.option,
    this.showIcon = true,
    this.showOption = true,
    this.onTap,
  }) : super(key: key);

  @override
  _ClassicsEmptyWidgetState createState() => _ClassicsEmptyWidgetState();
}

class _ClassicsEmptyWidgetState extends State<ClassicsEmptyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(context),
        _buildMessage(context),
        _buildOption(context)
      ],
    );
  }

  /// Icon
  Widget _buildIcon(BuildContext context) {
    if (!TextHelper.isEmpty(widget.icon) && widget.showIcon!) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Image.asset(
          widget.icon!,
          width: 100,
          height: 100,
        ),
        onTap: widget.onTap,
      );
    } else {
      return Container();
    }
  }

  /// Message
  Widget _buildMessage(BuildContext context) {
    String text = widget.message ?? S.of(context).alltip_nodata;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(color: AppColor.colorBE, fontSize: 18),
      ),
      onTap: widget.onTap,
    ));
  }

  Widget _buildOption(BuildContext context) {
    if (widget.showOption!) {
      String text = widget.option!; // ?? S.of(context).alltip_loading_error;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.color1A000, width: 1)),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.color87, fontSize: 14),
            )),
        onTap: widget.onTap,
      );
    } else {
      return Container();
    }
  }
}
