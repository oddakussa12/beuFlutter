import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * login_dialog.dart
 * 登录弹窗
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return LoginDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      insetPadding: PlatformSupport.ios()
          ? EdgeInsets.symmetric(horizontal: 60)
          : EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            child: Text(S.of(context).nologin_title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(16),
            child: Text(S.of(context).nologin_popo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.color66,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),

          /// 登录按钮
          buildLoginIn(context),

          /// 注册按钮
          buildRegister(context),

          Container(
            margin: EdgeInsets.only(top: 16),
            child: buildAgreementBarWidget(context),
          )
        ],
      ),
    );
  }

  Widget buildLoginIn(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFEF2626)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Text(S.of(context).login_login,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        /// 跳转登录
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.centre.Login);
      },
    );
  }

  Widget buildRegister(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.colorBE, width: 1),
          borderRadius: BorderRadius.circular(44),
        ),
        child: Text(S.of(context).login_creat_new_accont,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.centre.Register);
      },
    );
  }

  Widget buildAgreementBarWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: buildUserAgreement(context),
          ),
          Expanded(
            child: buildPrivacyPolicy(context),
          ),
        ],
      ),
    );
  }

  Widget buildUserAgreement(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 30,
        child: Text(
          S.of(context).textview_useragree,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.colorA8, fontSize: 13),
        ),
      ),
      onTap: () {
        /// 打开协议页
        Navigator.pushNamed(context, Routes.common.WebPage,
            arguments: {"title": "用户协议", "url": Constants.UserAgreement});
      },
    );
  }

  Widget buildPrivacyPolicy(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 30,
          child: Text(
            S.of(context).textview_secret,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.colorA8, fontSize: 13),
          )),
      onTap: () {
        Navigator.pushNamed(context, Routes.common.WebPage,
            arguments: {"title": "隐私协议", "url": Constants.PrivacyPolicy});
      },
    );
  }
}
