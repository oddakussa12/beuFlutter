import 'package:centre/src/pages/user_update_page.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * UserAccountPage
 * 用户账号信息
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: S.of(context).profile_account,
      ),
      body: SingleChildScrollView(
        child: buildPageBody(context),
      ),
    );
  }

  Widget buildPageBody(BuildContext context) {
    return Column(
      children: [
        /// 用户信息
        GestureDetector(
          child: _buildCommonItem(context, "res/icons/ic_account_profile.png",
              S.of(context).confirm_information),
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: TransitionType.rightToLeft, child: UserUpdatePage()));
          },
        ),

        /// 地址薄
        // GestureDetector(
        //   child: _buildCommonItem(
        //       context, "res/icons/ic_address_book.png", "Address book"),
        //   onTap: () {
        //     Navigator.pushNamed(context, Routes.address.AddressBook);
        //   },
        // ),
      ],
    );
  }

  Widget _buildCommonItem(BuildContext context, String imagePath, String text) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.42,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
                color: AppColor.bg,
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0,
                spreadRadius: 0.6),
            BoxShadow(color: AppColor.bg, offset: Offset(1.0, 1.0)),
            BoxShadow(color: AppColor.bg)
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            package: "resources",
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
