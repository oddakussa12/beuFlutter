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
class ToolbarOnlyTitle extends StatefulWidget implements PreferredSizeWidget {
  /// 标题
  final String? title;

  /// 菜单
  final List<Widget>? actions;

  const ToolbarOnlyTitle({Key? key, this.title = "", this.actions}) : super(key: key);

  @override
  _ToolbarOnlyTitleState createState() => _ToolbarOnlyTitleState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _ToolbarOnlyTitleState extends State<ToolbarOnlyTitle> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          elevation: AppSizes.elevation,
          backgroundColor: AppColor.white,
          centerTitle: true,
          title: Text(
            "${widget.title}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          actions: widget.actions,
        ),
        preferredSize: Size.fromHeight(50));
  }
}
