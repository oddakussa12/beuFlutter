import 'package:centre/centre.dart';
import 'package:common/common.dart';
import 'package:discover/dicover.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shopping.dart';

/**
 * home_page.dart
 * 主页
 *
 * @author: Ruoyegz
 * @date: 2021/7/9
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

/**
 * home_page.dart
 * 主页
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int pageIndex = 0;

  PageController _pageController = PageController(keepPage: true);

  /// tabs 对应的页面列表
  List<Widget> pageWidgets = [
    /*SpecialDiscoverPage(key: PageStorageKey<String>("DiscoverPage")),
    ShoppingMyBagPage(
      key: PageStorageKey<String>("ShoppingMyBagPage"),
    ),
    UserCentrePage(key: PageStorageKey<String>("UserCentrePage"))*/
  ];

  @override
  void initState() {
    super.initState();

    /// 订单创建成功回调
    BusClient().on<OrderCreatedEvent>().listen((event) {
      if (event != null) {
        _pageController.jumpToPage(2);
      }
    });

    /// 注册成功事件【切换到用户中心】
    BusClient().on<SignUpEvent>().listen((event) {
      if (event != null) {
        _pageController.jumpToPage(2);
      }
    });

    /// 登录成功事件【切换到用户中心】
    BusClient().on<SignInEvent>().listen((event) {
      if (event != null) {
        _pageController.jumpToPage(2);
      }
    });

    /// 登录成功事件【切换到用户中心】
    BusClient().on<LogoutEvent>().listen((event) {
      if (event != null) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (pageWidgets.isEmpty) {
      pageWidgets.add(
          SpecialDiscoverPage(key: PageStorageKey<String>("DiscoverPage")));
      pageWidgets.add(
          ShoppingMyBagPage(key: PageStorageKey<String>("ShoppingMyBagPage")));
      pageWidgets
          .add(UserCentrePage(key: PageStorageKey<String>("UserCentrePage")));
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogDog.w("Home-build");

    return Scaffold(
      backgroundColor: AppColor.white,
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: pageWidgets.length,
          onPageChanged: (index) {
            if (pageIndex != index) {
              setState(() {
                pageIndex = index;
              });
            }
          },
          itemBuilder: (context, index) {
            return pageWidgets[index];
          }),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    LogDog.d("Home-bottomNavigator");

    return BottomNavigationBar(
      elevation: 5,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: AppColor.white,
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              "res/icons/ic_nav_discover.png",
              package: "resources",
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              "res/icons/ic_nav_discover_active.png",
              package: "resources",
              width: 30,
              height: 30,
            ),
            label: "",
            tooltip: ""),
        BottomNavigationBarItem(
            icon: Image.asset(
              "res/icons/ic_nav_bag.png",
              package: "resources",
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              "res/icons/ic_nav_bag_active.png",
              package: "resources",
              width: 32,
              height: 32,
            ),
            label: "",
            tooltip: ""),
        BottomNavigationBarItem(
            icon: Image.asset(
              "res/icons/ic_nav_profile.png",
              package: "resources",
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              "res/icons/ic_nav_profile_active.png",
              package: "resources",
              width: 30,
              height: 30,
            ),
            label: "",
            tooltip: ""),
      ],
      currentIndex: pageIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.black,

      /// Item 点击事件
      onTap: (index) {
        if (index == 0 || UserManager().isLogin()) {
          _pageController.jumpToPage(index);
        } else {
          LoginDialog.show(context);
        }
      },
    );
  }
}
