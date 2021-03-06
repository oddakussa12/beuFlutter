import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

/**
 * app_bar.dart
 * 全局统一的 Toolbar
 *
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
class Toolbar extends StatefulWidget implements PreferredSizeWidget {
  /// 标题
  final String? title;

  final Widget? obiter;

  final Widget? back;

  /// 标题栏背景
  final Color? backgroundColor;

  /// 菜单
  final List<Widget>? actions;

  const Toolbar(
      {Key? key,
      this.title = "",
      this.obiter,
      this.back,
      this.backgroundColor = AppColor.white,
      this.actions})
      : super(key: key);

  @override
  _ToolbarState createState() => _ToolbarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          elevation: AppSizes.elevation,
          backgroundColor: widget.backgroundColor,
          centerTitle: true,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(13),
              child: widget.back ??
                  Image.asset(
                    "res/icons/ic_back_dark.png",
                    package: 'resources',
                  ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.title} ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
              widget.obiter ?? Container()
            ],
          ),
          actions: widget.actions,
        ),
        preferredSize: Size.fromHeight(50));
  }
}
