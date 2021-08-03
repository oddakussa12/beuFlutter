import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * 消息提示弹窗
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class MessageDialog extends StatelessWidget {
  /// 消息
  final String message;

  /// 左边操作按钮
  final String? leftOption;

  /// 是否现在左边按钮
  final bool? showLeft;

  /// 左边操作按钮点击事件
  final GestureTapCallback? onTapLeft;

  /// 右边操作按钮
  final String? rightOption;

  /// 是否现在右边按钮
  final bool? showRight;

  /// 右边操作按钮点击事件
  final GestureTapCallback? onTapRight;

  final bool? autoDismiss;

  const MessageDialog(
      {Key? key,
      required this.message,
      this.leftOption,
      this.showLeft = true,
      this.onTapLeft,
      this.rightOption,
      this.showRight = true,
      this.onTapRight,
      this.autoDismiss = true})
      : super(key: key);

  static void show(BuildContext context, String message,
      {String? left,
      bool? showLeft = true,
      GestureTapCallback? tapLeft,
      String? right,
      bool? showRight = true,
      GestureTapCallback? tapRight,
      bool? autoDismiss = true,
      bool? barrierDismiss = true}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismiss!,
        builder: (context) {
          return MessageDialog(
            message: message,
            leftOption: left ?? S.of(context).button_cancel,
            showLeft: showLeft,
            onTapLeft: tapLeft,
            rightOption: right ?? S.of(context).button_confirm,
            showRight: showRight,
            onTapRight: tapRight,
            autoDismiss: autoDismiss,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: PlatformSupport.ios()
          ? EdgeInsets.symmetric(horizontal: 40)
          : EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
            child: Text(TextHelper.clean(message),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(
                  color: AppColor.color37,
                  fontSize: 18,
                )),
          ),
          Row(
            children: [
              /// 左按钮
              showLeft!
                  ? Expanded(child: buildLeftOption(context))
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                    ),

              /// 右按钮
              showRight!
                  ? Expanded(child: buildRightOption(context))
                  : Container(margin: EdgeInsets.only(right: 16)),
            ],
          )
        ],
      ),
    );
  }

  /// 取消按钮
  Widget buildLeftOption(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16, right: 5, left: 16),
        decoration: BoxDecoration(
          color: AppColor.colorEF,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(leftOption ?? "",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 16,
            )),
      ),
      onTap: () {
        if (autoDismiss!) {
          Navigator.pop(context);
        }
        if (onTapLeft != null) {
          onTapLeft!.call();
        }
      },
    );
  }

  /// 确定按钮
  Widget buildRightOption(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16, left: 5, right: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFEF2626)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Text(rightOption ?? "",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: AppColor.white, fontSize: 16)),
      ),
      onTap: () {
        if (autoDismiss!) {
          Navigator.pop(context);
        }
        if (onTapRight != null) {
          onTapRight!.call();
        }
      },
    );
  }
}
