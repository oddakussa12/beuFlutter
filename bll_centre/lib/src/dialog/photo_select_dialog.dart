import 'package:common/common.dart';
import 'package:flutter/material.dart';

/// 弹窗选择项点击事件
typedef SelectItemTap = void Function(int index);

/**
 * PhotoSelectDialog
 * 图片选择弹窗
 * @author: Ruoyegz
 * @date: 2021/7/28
 */
class PhotoSelectDialog extends StatelessWidget {
  final String? title;

  /// 弹窗选择项点击事件
  final SelectItemTap? itemTap;

  const PhotoSelectDialog({Key? key, this.title, this.itemTap})
      : super(key: key);

  static void showDialog(BuildContext context, {String? title, SelectItemTap? itemTap}) {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return PhotoSelectDialog(
            //title: title,
            itemTap: itemTap,
          );
        });
  }

  void s() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TextHelper.isEmpty(title) ? 134 : 190,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        children: [
          TextHelper.isEmpty(title)
              ? Container()
              : Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              title!,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 选择图片
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                "选择图片",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              if (itemTap != null) {
                Navigator.pop(context);
                itemTap!.call(1);
              }
            },
          ),

          Container(
            color: AppColor.color08000,
            height: 1,
          ),

          /// 拍摄照片
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                "拍摄照片",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              if (itemTap != null) {
                Navigator.pop(context);
                itemTap!.call(2);
              }
            },
          ),
        ],
      ),
    );
  }
}
