import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * AgreementBarWidget
 *
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
class AgreementBarWidget extends StatelessWidget {
  const AgreementBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          buildUserAgreement(context),
          buildPrivacyPolicy(context),
          Expanded(
            child: Container(),
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
        padding: EdgeInsets.only(right: 8),
        child: Text(
          S.of(context).textview_useragree,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.colorA8, fontSize: 13),
        ),
      ),
      onTap: () {
        /// 打开协议页
        Navigator.pushNamed(context, Routes.common.WebPage,
            arguments: {"title": S.of(context).textview_useragree, "url": Constants.UserAgreement});
      },
    );
  }

  Widget buildPrivacyPolicy(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 30,
          padding: EdgeInsets.only(left: 8),
          child: Text(
            S.of(context).textview_secret,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.colorA8, fontSize: 13),
          )),
      onTap: () {
        Navigator.pushNamed(context, Routes.common.WebPage,
            arguments: {"title": S.of(context).setting_privacy, "url": Constants.PrivacyPolicy});
      },
    );
  }
}
