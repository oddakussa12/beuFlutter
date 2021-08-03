import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * UpdateVersionDialog
 * 更新版本
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
class UpdateVersionDialog extends StatelessWidget {
  final String version;
  final String desc;

  const UpdateVersionDialog(
      {Key? key, required this.version, required this.desc})
      : super(key: key);

  static void show(BuildContext context, String version, String desc,
      {bool isDismissible = true}) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (context) {
          return UpdateVersionDialog(
            version: version,
            desc: desc,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding: PlatformSupport.ios()
          ? EdgeInsets.symmetric(horizontal: 40)
          : EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppColor.colorF8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// LOGO
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 16),
            child: Image.asset(
              "res/images/ic_launcher.png",
              package: "resources",
              height: 76,
              width: 76,
            ),
          ),

          /// 版本号
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: TextHelper.isNotEmpty(version)
                ? Text(version,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
                : null,
          ),

          /// 版本描述
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(16),
            child: Text(desc,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1.6,
                  color: AppColor.color45,
                  fontSize: 14,
                )),
          ),

          /// 更新按钮
          buildUpdateButton(context),
        ],
      ),
    );
  }

  /// 更新按钮
  Widget buildUpdateButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFEF2626)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Text(S.of(context).setupdata_updateapp,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        /// 跳转用于市场
        Navigator.pop(context);
        LaunchReview.launch(
            androidAppId: Constants.ANDROID_APP_ID,
            iOSAppId: Constants.IOS_APP_ID);
      },
    );
  }
}
