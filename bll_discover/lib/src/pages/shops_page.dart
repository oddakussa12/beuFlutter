import 'package:common/common.dart';
import 'package:discover/src/actuator/shops_actuator.dart';
import 'package:discover/src/items/item_shop_grid_stateless.dart';
import 'package:discover/src/pages/special_discover_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';

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

    // actuator.init(UserAddress(name: "a", phone: "123"));
    actuator.checkLocation(fail: (LocationClient client, LFailType type) {
      
      if (client != null && type != null) {
        if (LFailType.ServiceUnusable == type) {
          /// 定位服务未开启
          showLocationPermissionAlert(S.of(context).alltip_gps_noopen);
        } else if (LFailType.Denied == type) {
          /// 定位权限未授予
          showLocationPermissionAlert(S.of(context).alltip_position_noopen);
        } else if (LFailType.DeniedForever == type) {
          /// 定位权限未授予被永久关闭【拒绝授权，且不让提示的那种】
          showLocationPermissionAlert(S.of(context).alltip_position_closeopen);
        }
      }
    });
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
          crossAxisSpacing: 15,
          mainAxisSpacing: 28,
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

  void showLocationPermissionAlert(String message) {
    MessageDialog.show(context, message, tapRight: () {
      actuator.updateLocation(fail: (LocationClient client, LFailType type) {
        if (client != null && type != null) {
          if (LFailType.ServiceUnusable == type) {
            client.openLocationSettings();
          } else if (LFailType.Denied == type) {
            // client.openSettings();
          } else if (LFailType.DeniedForever == type) {
            client.openSettings();
          }
        }
      });
    });
  }
}
