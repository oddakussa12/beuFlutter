import 'package:centre/src/actuator/user_setting_actuator.dart';
import 'package:centre/src/dialog/update_version_dialog.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';


/**
 * UserSettingActuator
 *
 * @author: Ruoyegz
 * @date: 2021/7/29
 */
class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  _UserSettingPageState createState() =>
      _UserSettingPageState(UserSettingActuator());
}

class _UserSettingPageState
    extends ReactableState<UserSettingActuator, UserSettingPage> {
  _UserSettingPageState(UserSettingActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.loadCacheSize();
  }

  /// 退出登录
  void logout() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, Routes.centre.Login);
    UserManager().logout();
  }

  void checkAppVersion() {
    actuator.checkAppVersion((info) {
      UpdateVersionDialog.show(context, info.last, info.upgrade_point,
          isDismissible: !info.mustUpgrade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: Toolbar(title: S.of(context).setting_title),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Column(
            children: [
              /// 版本更新
              buildUpdateVersion(),

              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: AppColor.color08000,
              ),

              /// 用户协议
              buildUserAgreement(),

              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: AppColor.color08000,
              ),

              /// 隐私协议
              buildPrivacyAgreement(),

              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: AppColor.color08000,
              ),

              /// 关于 beU
              buildAbout(),

              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: AppColor.color08000,
              ),

              /// 清理缓存
              buildCleanCache(),

              buildLogout(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpdateVersion() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(
              "res/icons/ic_setting_version.png",
              package: "resources",
              height: 34,
              width: 34,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                S.of(context).setting_newversion,
                style: TextStyle(color: AppColor.black, fontSize: 16),
              ),
            )),
            Icon(Icons.keyboard_arrow_right, color: AppColor.color99),
          ],
        ),
      ),
      onTap: () {
        checkAppVersion();
      },
    );
  }

  Widget buildUserAgreement() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(
              "res/icons/ic_setting_privacy_agreement.png",
              package: "resources",
              height: 34,
              width: 34,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                S.of(context).textview_useragree,
                style: TextStyle(color: AppColor.black, fontSize: 16),
              ),
            )),
            Icon(Icons.keyboard_arrow_right, color: AppColor.color99),
          ],
        ),
      ),
      onTap: () async {
        Navigator.pushNamed(context, Routes.common.WebPage, arguments: {
          "title": S.of(context).textview_useragree,
          "url": Constants.UserAgreement
        });
      },
    );
  }

  /// 隐私协议
  Widget buildPrivacyAgreement() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(
              "res/icons/ic_setting_user_agreement.webp",
              package: "resources",
              height: 34,
              width: 34,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 6),
              child: Text(
                S.of(context).setting_privacy,
                style: TextStyle(color: AppColor.black, fontSize: 16),
              ),
            )),
            Icon(Icons.keyboard_arrow_right, color: AppColor.color99),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.common.WebPage, arguments: {
          "title": S.of(context).setting_privacy,
          "url": Constants.PrivacyPolicy
        });
      },
    );
  }

  /// 关于 beU
  Widget buildAbout() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset(
            "res/icons/ic_setting_about.webp",
            package: "resources",
            height: 34,
            width: 34,
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            child: Text(
              S.of(context).setting_about,
              style: TextStyle(color: AppColor.black, fontSize: 16),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 5),
            child: Text(
              "${Constants.appVersion}",
              style: TextStyle(color: AppColor.color37, fontSize: 14),
            ),
          )),
        ],
      ),
    );
  }

  /// 清理缓存
  Widget buildCleanCache() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset(
            "res/icons/ic_setting_clean_cache.webp",
            package: "resources",
            height: 34,
            width: 34,
          ),
          Container(
            margin: EdgeInsets.only(left: 6),
            child: Text(
              S.of(context).setting_cleancache,
              style: TextStyle(color: AppColor.black, fontSize: 16),
            ),
          ),
          Expanded(
              child: GestureDetector(
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 5),
              child: Text(
                "${actuator.cacheSize}",
                style: TextStyle(color: AppColor.color37, fontSize: 14),
              ),
            ),
            onTap: () {
              showCleanAlertDialog(context);
            },
          )),
        ],
      ),
    );
  }

  void showCleanAlertDialog(BuildContext context) {
    actuator.isNeedClean((result) {
      MessageDialog.show(context, S.of(context).setcache_confirm, tapRight: () {
        actuator.cleanCache();
      });
    });
  }

  Widget buildLogout(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, left: 10, right: 10),
        decoration: BoxDecoration(
          color: AppColor.color1A000,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text("退出登录",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        /// 退出登录提示弹窗
        MessageDialog.show(context, S.of(context).setout_confirm,
            tapRight: logout);
      },
    );
  }
}
