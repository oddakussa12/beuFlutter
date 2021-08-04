import 'package:centre/src/actuator/follow_shops_actuator.dart';
import 'package:centre/src/items/item_follow_shop.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * FollowShopsPage
 * 关注的店铺
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class FollowShopsPage extends StatefulWidget {
  const FollowShopsPage({Key? key}) : super(key: key);

  @override
  _FollowShopsPageState createState() =>
      _FollowShopsPageState(FollowShopsActuator());
}

class _FollowShopsPageState
    extends RefreshableState<FollowShopsActuator, FollowShopsPage> {
  _FollowShopsPageState(FollowShopsActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(
          title: S.of(context).profile_shop,
        ),
        body: SmartRefresher(
            controller: refreshController,
            physics: BouncingScrollPhysics(),
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            enablePullDown: actuator.emptyStatus == EmptyStatus.Normal,
            enablePullUp: actuator.emptyStatus == EmptyStatus.Normal,
            onRefresh: () {
              actuator.pullDown();
            },
            onLoading: () {
              actuator.pullUp();
            },
            child: actuator.isNotNormal()
                ? buildEmptyWidget(context)
                : buildShops()));
  }

  GridView buildShops() {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.76,
        ),
        itemCount: actuator.shops.length,
        itemBuilder: (BuildContext context, int index) {
          Shop shop = actuator.shops[index];
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            child: ItemFollowShopWidget(
                key: Key("${shop.id}-${shop.name}"), shop: shop),
            onTap: () => clickShop(context, shop),
          );
        });
  }

  /**
   * 打开商铺详情
   */
  void clickShop(BuildContext context, Shop shop) {
    Navigator.pushNamed(context, Routes.shopping.ShopDetail, arguments: shop);
  }
}
