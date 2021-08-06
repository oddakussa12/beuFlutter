import 'package:common/common.dart';
import 'package:discover/src/actuator/special_discover_actuator.dart';
import 'package:discover/src/pages/products_page.dart';
import 'package:discover/src/pages/shops_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 重试加载特价商品
typedef RetrySpecialCallback = void Function();

/**
 * SpecialDiscoverPage
 * 特价发现页
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
class SpecialDiscoverPage extends StatefulWidget {
  const SpecialDiscoverPage({Key? key}) : super(key: key);

  @override
  State<SpecialDiscoverPage> createState() =>
      new SpecialDiscoverPageState(SpecialDiscoverActuator());
}

class SpecialDiscoverPageState
    extends ReactableState<SpecialDiscoverActuator, SpecialDiscoverPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabNames = [];
  final List<Widget> _pageWidgets = [];

  SpecialDiscoverPageState(SpecialDiscoverActuator actuator) : super(actuator);

  @override
  void initState() {
    super.initState();
    LogDog.e("Discover-initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tabNames.isEmpty) {
      tabNames.add(S.of(context).discover_shops);
      tabNames.add(S.of(context).discover_product);
    }
    if (_pageWidgets.isEmpty) {
      _pageWidgets.add(ShopsPage(callback: () {
        retryLoadSpecial();
      }));
      _pageWidgets.add(ProductsPage(
        callback: () {
          retryLoadSpecial();
        },
      ));
    }

    _tabController = TabController(length: _pageWidgets.length, vsync: this);

    actuator.loadSpecialGoods();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  void retryLoadSpecial() {
    actuator.loadSpecialGoods();
  }

  /// 打开特价商品
  void prepareOpenSpecialProducts() {
    if (actuator.special.count > 0) {
      Navigator.pushNamed(context, Routes.special.SpecialProducts);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogDog.e("SpecialDiscover-build");
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 310,
            pinned: true,
            floating: false,
            leading: Constants.isDevelop
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "res/images/ic_launcher.png",
                      package: 'resources',
                      width: 36,
                      height: 36,
                    ),
                  )
                : null,
            title: Constants.isDevelop ? buildSearchBar() : null,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: GestureDetector(
                  child: CachedNetworkImage(
                    alignment: Alignment.topCenter,
                    fadeInDuration: const Duration(milliseconds: 200),
                    imageUrl: TextHelper.clean(actuator.special.image),
                    placeholder: (context, url) => Image.asset(
                        "res/images/def_cover_1_1.png",
                        package: 'resources',
                        fit: BoxFit.fitWidth,
                        height: MediaQuery.of(context).size.width * 0.827,
                        gaplessPlayback: true,
                        width: MediaQuery.of(context).size.width),
                    errorWidget: (context, url, error) => Image.asset(
                        "res/images/def_cover_1_1.png",
                        package: 'resources',
                        fit: BoxFit.fitWidth,
                        height: MediaQuery.of(context).size.width * 0.827,
                        gaplessPlayback: true,
                        width: MediaQuery.of(context).size.width),
                    height: MediaQuery.of(context).size.width * 0.827,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  onTap: prepareOpenSpecialProducts,
                )),
            bottom: PreferredSize(
              child: Container(
                color: AppColor.white,
                child: TabBar(
                  indicatorColor: AppColor.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 6),
                  unselectedLabelColor: AppColor.colorBE,
                  labelColor: AppColor.color0F0F17,
                  labelStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 14),
                  controller: _tabController,
                  tabs: tabNames.map((e) => Tab(text: e)).toList(),
                ),
              ),
              preferredSize: Size.fromHeight(48),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: _pageWidgets,
          physics: PageScrollPhysics(),
        ),
      ),
    );
  }

  Widget buildToolbar() {
    return AppBar(
      elevation: AppSizes.elevation,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// logo
          GestureDetector(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "res/images/ic_launcher.png",
                package: 'resources',
                width: 32,
                height: 32,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.special.SpecialProducts);
            },
          ),

          /// app name
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              S.of(context).app_name,
              style: TextStyle(color: AppColor.black, fontSize: 19),
            ),
          )),

          /// tab 样式
          buildTab()
        ],
      ),
    );
  }

  /// tab 样式
  PreferredSize buildTab() {
    return PreferredSize(
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        /*indicator: BubbleTabIndicator(
          indicatorHeight: 30.0,
          indicatorColor: AppColor.black,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),*/
        indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
        unselectedLabelColor: AppColor.color80000,
        labelColor: AppColor.white,
        controller: _tabController,
        tabs: tabNames.map((e) => Tab(text: e)).toList(),
      ),
      preferredSize: Size.fromHeight(30),
    );
  }

  /**
   * 顶部搜索栏
   */
  Widget buildSearchBar() {
    return Container(
      height: 36,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 1, right: 1),
      decoration: BoxDecoration(
          color: AppColor.colorF9,
          border: Border.all(color: AppColor.color08000, width: 1),
          borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "res/icons/ic_bar_search.png",
            package: 'resources',
            width: 16,
            height: 16,
            color: AppColor.colorBE,
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    S.of(context).reminder_search,
                    style: TextStyle(color: AppColor.colorBE, fontSize: 14),
                  ))),
        ],
      ),
    );
  }
}
