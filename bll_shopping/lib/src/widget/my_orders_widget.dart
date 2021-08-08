import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/my_orders_actuator.dart';
import 'package:shopping/src/items/item_my_orders_order.dart';

import '../controller/my_orders_controller.dart';

/**
 * my_orders_page.dart
 * 我的订单表
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@deprecated
class MyOrdersWidget extends StatefulWidget {
  final MyOrderController orderController;

  const MyOrdersWidget({Key? key, required this.orderController})
      : super(key: key);

  @override
  MyOrdersWidgetState createState() => MyOrdersWidgetState(MyOrdersActuator());
}

class MyOrdersWidgetState
    extends RefreshableState<MyOrdersActuator, MyOrdersWidget>
    with AutomaticKeepAliveClientMixin {
  MyOrdersWidgetState(MyOrdersActuator actuator) : super(actuator);

  @override
  void initState() {
    super.initState();
    if (widget.orderController != null) {
      widget.orderController.initState(this);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (actuator.myOrders == null || actuator.myOrders.isEmpty) {
      return buildEmptyWidget(
        context,
        message: S.of(context).alltip_nodata,
      );
    }

    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          shrinkWrap: true,
          itemCount: actuator.myOrders.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var order = actuator.myOrders[index];
            return Container(
              child: ItemMyOrdersOrderWidget(
                key: Key("${order.id}-${order.userId}"),
                shop: order.shop!,
                order: order,
                orderNumber: index,
              ),
            );
          }),
    );
  }
}
