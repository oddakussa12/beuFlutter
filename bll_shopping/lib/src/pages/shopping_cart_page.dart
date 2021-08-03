
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'my_bag_page.dart';
import 'my_orders_page.dart';

/**
 * shopping_cart_page.dart
 * 购物车页面
 * 暂时将我的订单移到个人中心
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@deprecated
class ShoppingCartPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPageWidget>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabTitles = [];

  @override
  void initState() {
    super.initState();
    BusClient().on<OrderCreatedEvent>().listen((event) {
      if (event != null) {
        setState(() {
          _tabController.index = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    if (tabTitles.isEmpty) {
      tabTitles.add(S.of(context).shopcart_my_bag);
      tabTitles.add(S.of(context).shopcart_my_orders);
      _tabController = new TabController(length: tabTitles.length, vsync: this);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: AppSizes.elevation,
        centerTitle: true,

        /// 顶部搜索栏
        title: Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width / 1.5,
          child: PreferredSize(
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: AppColor.black,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
              unselectedLabelColor: AppColor.color80000,
              labelColor: AppColor.white,
              controller: _tabController,
              tabs: tabTitles.map((e) => Tab(text: e)).toList(),
            ),
            preferredSize: Size.fromHeight(38),
          ),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [MyBagPageWidget(), MyOrdersPage()]),
    );
  }
}
