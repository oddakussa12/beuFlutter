import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '../../shopping.dart';

/**
 * MyOrdersActuator
 *
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
@deprecated
class MyOrdersActuator extends RefreshActuator {
  /// 我的订单列表
  List<Order> myOrders = [];

  @override
  void attach(BuildContext context, Viewer view) {
    super.attach(context, view);

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(
        BusClient().subscribe<OrderCreatedEvent>((e) => pullDown()));
  }

  void cleanMyOrders() {
    myOrders.clear();
    notifySetState();
  }

  @override
  void dispose() {
    super.dispose();
    myOrders.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    if (myOrders.isEmpty) {
      pullDown();
    }
  }

  @override
  void onRefreshSource(int page, PullType type) {
    _loadMyOrders(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    _loadMyOrders(page, type);
  }

  void _loadMyOrders(int page, PullType type) async {
    DioClient().get("${ShoppingUrl.myOrders}?page=${page}",
        (response) => MyOrdersBody.fromJson(response.data),
        success: (MyOrdersBody body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          myOrders.clear();
        }
        myOrders.addAll(body.data);
      }
    }, complete: () {
      notifySetState();
    });
  }
}
