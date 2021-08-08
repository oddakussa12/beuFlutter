
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopping/src/actuator/my_orders_actuator.dart';
import 'package:shopping/src/items/item_my_orders_order.dart';

/**
 * my_orders_page.dart
 * 我的订单表
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState(MyOrdersActuator());
}

class _MyOrdersPageState
    extends RefreshableState<MyOrdersActuator, MyOrdersPage>
    with AutomaticKeepAliveClientMixin {
  _MyOrdersPageState(MyOrdersActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: actuator.isNotNormal() ? buildEmptyWidget(context) :
      SmartRefresher(
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
          child: ListView.builder(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              shrinkWrap: true,
              itemCount: actuator.myOrders.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var order = actuator.myOrders[index];
                return Container(
                  child: ItemMyOrdersOrderWidget(
                    key: Key("${order.id}"),
                    shop: order.shop!,
                    order: order,
                    orderNumber: index,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
