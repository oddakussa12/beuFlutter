import 'package:centre/src/actuator/user_centre_actuator.dart';
import 'package:centre/src/pages/follow_shops_page.dart';
import 'package:centre/src/pages/user_account_page.dart';
import 'package:centre/src/pages/user_setting_page.dart';
import 'package:centre/src/pages/my_orders_widget.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'login_page.dart';

/**
 * UserCentrePage
 * 用户中心
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
class UserCentrePage extends StatefulWidget {
  const UserCentrePage({Key? key}) : super(key: key);

  State<UserCentrePage> createState() => UserCentreState(UserCentreActuator());
}

class UserCentreState
    extends RefreshableState<UserCentreActuator, UserCentrePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  UserCentreState(UserCentreActuator actuator) : super(actuator);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    LogDog.w("UserCentrePage, build");
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: ToolbarOnlyTitle(
        title: TextHelper.clean(actuator.user.nickName),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Image.asset(
                "res/icons/ic_setting.png",
                package: "resources",
                width: 20,
                height: 20,
              ),
            ),
            onTap: () {
              //logout();
              Navigator.push(
                  context,
                  PageTransition(
                      type: TransitionType.rightToLeft,
                      child: UserSettingPage()));
            },
          )
        ],
      ),
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        controller: refreshController,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () {
          actuator.pullDown();
        },
        onLoading: () {
          actuator.pullUp();
        },
        child: SingleChildScrollView(
          child: buildUserInfoBody(context),
        ),
      ),
    );
  }

  /**
   * 用户信息
   */
  Widget buildUserInfoBody(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              /// 背景
              buildUserBackground(context),

              /// 头像
              buildUserAvatar(),
            ],
          ),

          /// 昵称
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              TextHelper.clean(actuator.user.nickName),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.h1,
                fontSize: 18,
              ),
            ),
          ),

          /// 操作按钮
          buildOptionButton(),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Text(
              S.of(context).shopcart_my_orders,
              textAlign: TextAlign.left,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 我的订单
          MyOrdersWidget(orderController: actuator.controller)
        ],
      ),
    );
  }

  /**
   * 构建背景
   */
  Widget buildUserBackground(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(actuator.user.bg),
            placeholder: (context, url) => Image.asset(
                "res/images/def_cover_8_5.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 176,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_cover_8_5.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 176,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            height: 176,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建头像
   */
  Widget buildUserAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 122),
      alignment: Alignment.topCenter,
      child: Container(
        height: 105,
        width: 105,
        decoration: BoxDecoration(
            color: AppColor.colorEF,
            border: Border.all(color: Colors.white, width: 3.82),
            borderRadius: BorderRadius.circular(105)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(105),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(actuator.user.avatarLink),
            placeholder: (context, url) => Image.asset(
              "res/images/def_avatar.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 105,
              width: 105,
              gaplessPlayback: true,
            ),
            errorWidget: (context, url, error) => Image.asset(
              "res/images/def_avatar.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 105,
              width: 105,
              gaplessPlayback: true,
            ),
            height: 105,
            width: 105,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildOptionButton() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 44,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20, left: 16, right: 6),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.color1A000, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                S.of(context).profile_shop,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: TransitionType.rightToLeft,
                      child: FollowShopsPage()));
            },
          ),
        ),

        /// 账号信息
        Expanded(
          child: GestureDetector(
            child: Container(
              height: 44,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20, left: 6, right: 16),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: AppColor.color1A000, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                S.of(context).profile_account,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: TransitionType.rightToLeft,
                      child: UserAccountPage()));
            },
          ),
        ),
      ],
    );
  }
}
