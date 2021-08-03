import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 *
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class LogoutAlertDialog extends StatelessWidget {
  final GestureTapCallback onTap;
  const LogoutAlertDialog({Key? key, required this.onTap}) : super(key: key);

  static void show(BuildContext context, GestureTapCallback onTap) {
    showDialog(
        context: context,
        builder: (context) {
          return LogoutAlertDialog(onTap: onTap,);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: PlatformSupport.ios()
          ? EdgeInsets.symmetric(horizontal: 40)
          : EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 170,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(16),
                child: Text(S.of(context).setout_confirm,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 18,
                    )),
              ),
            ),
            Row(
              children: [
                /// 登录按钮
                Expanded(child: buildCancel(context)),

                /// 注册按钮
                Expanded(child: buildSure(context))
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 取消按钮
  Widget buildCancel(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16, right: 5),
        decoration: BoxDecoration(
          color: AppColor.colorEF,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(S.of(context).button_cancel,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  /// 确定按钮
  Widget buildSure(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 16, left: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFEF2626)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Text(S.of(context).button_confirm,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        /// 跳转登录
        Navigator.pop(context);
        if(onTap != null){
          onTap.call();
        }
      },
    );
  }
}
