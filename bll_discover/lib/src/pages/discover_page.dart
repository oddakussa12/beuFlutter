import 'package:common/common.dart';
import 'package:discover/src/pages/products_page.dart';
import 'package:discover/src/pages/shops_page.dart';
import 'package:flutter/material.dart';

/**
 * discover_page.dart
 * 发现页
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@deprecated
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => new DiscoverPageState();
}

class DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabNames = [];
  final List<Widget> _pageWidgets = [ShopsPage(), ProductsPage()];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabNames.add(S
        .of(context)
        .discover_shops);
    tabNames.add(S
        .of(context)
        .discover_product);

    _tabController = TabController(length: _pageWidgets.length, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogDog.e("Discover-build");
    return Scaffold(
      appBar: PreferredSize(
        child: buildToolbar(),
        preferredSize: Size.fromHeight(PlatformSupport.web() ? 80 : 50),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pageWidgets,
        physics: PageScrollPhysics(),
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
          GestureDetector(child: Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "res/images/ic_launcher.png",
              package: 'resources',
              width: 32,
              height: 32,
            ),
          ), onTap: () {
            Navigator.pushNamed(context, Routes.special.SpecialProducts);
          },),

          /// app name
          Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  S
                      .of(context)
                      .app_name,
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
  Widget buildTab() {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 2,
        alignment: Alignment.centerRight,
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
            tabs: tabNames.map((e) => Tab(text: e)).toList(),
          ),
          preferredSize: Size.fromHeight(30),
        ));
  }

  /**
   * 顶部搜索栏
   */
  Widget buildSearchBar() {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
          color: AppColor.color08000,
          border: Border.all(color: AppColor.color08000, width: 1),
          borderRadius: BorderRadius.circular(4)),
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
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Search a shop of product",
                    style: TextStyle(color: AppColor.hint, fontSize: 14),
                  ))),
          Image.asset(
            "res/icons/ic_bar_close.png",
            package: 'resources',
            width: 16,
            height: 16,
          )
        ],
      ),
    );
  }
}
