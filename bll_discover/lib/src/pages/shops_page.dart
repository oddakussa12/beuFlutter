import 'package:common/common.dart';
import 'package:discover/src/actuator/shops_actuator.dart';
import 'package:discover/src/items/item_shop_grid_stateless.dart';
import 'package:discover/src/pages/special_discover_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * shops_page.dart
 * 发现页-商品列表
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
class ShopsPage extends StatefulWidget {
  RetrySpecialCallback? callback;

  ShopsPage({this.callback});

  @override
  State<ShopsPage> createState() => new _ShopsState(ShopsActuator());
}

class _ShopsState extends RefreshableState<ShopsActuator, ShopsPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  _ShopsState(presenter) : super(presenter);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    actuator.callback = widget.callback;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogDog.d("ShopsPage-build");

    return SmartRefresher(
        controller: refreshController,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        enablePullDown: false,
        enablePullUp: actuator.emptyStatus == EmptyStatus.Normal,
        onRefresh: () {
          actuator.pullDown();
        },
        onLoading: () {
          actuator.pullUp();
        },
        child: actuator.isNotNormal()
            ? buildEmptyWidget(context,
                message: S.of(context).allpage_shopnofind)
            : buildShops());
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
            child: ItemShopGridStatelessWidget(
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
