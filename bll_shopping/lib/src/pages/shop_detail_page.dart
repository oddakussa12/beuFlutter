import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopping/src/actuator/shop_detail_actuator.dart';
import 'package:shopping/src/widget/cart/shopping_cart_bar.dart';
import 'package:shopping/src/controller/shopping_cart_controller.dart';

/**
 * shop_detail_page.dart
 * 商铺详情
 * @author: Ruoyegz
 * @date: 2021/7/1
 */
class ShopDetailPage extends StatefulWidget {
  const ShopDetailPage({Key? key}) : super(key: key);

  @override
  _ShopDetailPageState createState() =>
      _ShopDetailPageState(ShopDetailActuator());
}

class _ShopDetailPageState
    extends RefreshableState<ShopDetailActuator, ShopDetailPage> {
  final ShoppingCartBarController barController =
      new ShoppingCartBarController();

  _ShopDetailPageState(ShopDetailActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    

    /// 外部传入的商铺参数

   var args = ModalRoute.of(context)!.settings.arguments;
   actuator.initShopDetail(args as Shop, barController);
  }

  @override
  void dispose() {
    if (actuator.isShoppingCartChanged && actuator.shopDetail != null) {
      BusClient().fire(ShoppingCartEvent(actuator.shopDetail.id));
    }
    super.dispose();
  }

  /**
   * 添加购物车操作
   */
  @override
  void appendShopCart(Product product) {
    barController.outsideAddProduct(product, actuator.shopDetail);
  }

  /// 收藏店铺
  void prepareFollowShop() {
    if (UserManager().isLogin()) {
      if (!actuator.shopDetail.followState!) {
        actuator.followShop(start: () {
          LoadingDialog.show(context);
        }, complete: () {
          Navigator.pop(context);
        });
      }
    } else {
      LoginDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: TextHelper.clean(actuator.shopDetail.name),
        obiter: Offstage(
          offstage: actuator.shopDetail.level != 1,
          child: Image.asset(
            "res/icons/ic_certified_shop.png",
            width: 18,
            height: 16,
            package: "resources",
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SmartRefresher(
            physics: BouncingScrollPhysics(),
            controller: refreshController,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () {
              if (UserManager().delivery(actuator.shopDetail)) {
                barController.refreshShoppingCart();
                barController.closeShopCart();
              }
              actuator.pullDown();
            },
            onLoading: () {
              barController.closeShopCart();
              actuator.pullUp();
            },
            child: SingleChildScrollView(
              child: buildShopBody(context),
            ),
          ),

          /// 底部购物车
          ShoppingCartBar(
            isShowBar: UserManager().delivery(actuator.shopDetail),
            isCartProducts: UserManager().delivery(actuator.shopDetail),
            shopId: actuator.shopDetail.id,
            controller: barController,
          ),
        ],
      ),
    );
  }

  /**
   * 商铺
   */
  Widget buildShopBody(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(vertical: 16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  /// 商铺背景
                  buildShopBackground(context),

                  /// 派送图标: shop.delivery
                  buildDeliveryIcon(actuator.shopDetail.delivery),

                  /// 商铺头像
                  buildShopAvatar(),
                  // Text("data")
                ],
              ),

              /// 商铺标题
              buildShopNickName(),

              /// 商铺评分
              buildShopStarBar(actuator.shopDetail),

              /// 商铺地址
              buildShopAddress(),

              /// 商铺电话
              buildShopContact(),

              /// 商铺介绍
              buildShopDesc(),

              /// Follow
              buildFollowButton(),

              Container(
                height: 2,
                margin: EdgeInsets.symmetric(vertical: 16),
                color: AppColor.color08000,
              ),

              /// 商品列表标题
              buildProductsHeadline(),

              /// 商铺商品列表
              buildShopProducts(context)
            ],
          ),
          onTap: () {
            barController.closeShopCart();
          },
        ));
  }

  /**
   * 构建商铺背景
   */
  Widget buildShopBackground(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(actuator.shopDetail.bg),
            placeholder: (context, url) => Image.asset(
                "res/images/def_shop_image.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 176,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_shop_image.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 176,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            height: 176,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建商铺头像
   */
  Widget buildShopAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 122),
      alignment: Alignment.topCenter,
      child: Container(
        height: 105,
        width: 105,
        decoration: BoxDecoration(
            color: AppColor.colorEF,
            border: Border.all(color: Colors.white, width: 3.82),
            borderRadius: BorderRadius.circular(105)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(105),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(actuator.shopDetail.avatarLink),
            placeholder: (context, url) => Image.asset(
              "res/images/def_avatar.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 105,
              width: 105,
              gaplessPlayback: true,
            ),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_avatar.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 105,
                width: 105,
                gaplessPlayback: true),
            height: 105,
            width: 105,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /**
   * 外面图标
   */
  Container buildDeliveryIcon(bool? ableDelivery) {
    if (ableDelivery != null && ableDelivery) {
      return Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 12, right: 26),
        child: Image.asset(
          "res/icons/ic_shop_delivery.png",
          package: 'resources',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildShopNickName() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Text(
        actuator.shopDetail.nickName ?? actuator.shopDetail.name ?? "",
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.h1, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /**
   * 商铺评分条
   */
  Widget buildShopStarBar(Shop shop) {
    UserPoint point = shop.getShopPoint();

    /// 当商铺的评分为零时，不显示 star bar
    if (point.point <= 0) {
      return Container();
    }

    List<Widget> stars = [];

    /// 评论数
    if (point.comment > 0) {
      stars.add(Container(
        margin: EdgeInsets.only(left: 10, right: 5),
        child: Text(
          "(${point.comment})",
          style: TextStyle(color: AppColor.colorBE, fontSize: 14),
        ),
      ));
    }

    /// 星
    double star = point.point;
    for (int i = 1; i <= 5; i++) {
      stars.add(buildSopStar(star >= i));
    }

    /// 评分
    if (star > 0) {
      stars.add(Container(
        margin: EdgeInsets.only(left: 5, right: 10),
        child: Text(
          "(${ValueFormat.formatDouble(star)})",
          style: TextStyle(color: AppColor.colorF7551D, fontSize: 12),
        ),
      ));
    }
    return IntrinsicWidth(
      child: Container(
        height: 24,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColor.colorBE, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: stars,
        ),
      ),
    );
  }

  Widget buildSopStar(bool isLight) {
    if (isLight) {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            "res/icons/ic_star_light.png",
            package: 'resources',
            width: 10,
            height: 10,
          ));
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        child: Image.asset(
          "res/icons/ic_star_dark.png",
          package: 'resources',
          width: 10,
          height: 10,
        ),
      );
    }
  }

  /// 商铺地址
  Widget buildShopAddress() {
    return Visibility(
      visible: TextHelper.isNotEmpty(actuator.shopDetail.address),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 12, left: 16, right: 16),
        child: Text(
          TextHelper.clean(actuator.shopDetail.address),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColor.colorBE, fontSize: 14),
        ),
      ),
    );
  }

  Widget buildShopContact() {
    return Visibility(
      visible: TextHelper.isAnyNotEmpty(
          [actuator.shopDetail.callCenter, actuator.shopDetail.contact]),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 12, left: 16, right: 16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Text(
            TextHelper.cleanFirst(
                [actuator.shopDetail.callCenter, actuator.shopDetail.contact]),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.colorF7551D,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            launch("tel://${TextHelper.cleanFirst([
                  actuator.shopDetail.callCenter,
                  actuator.shopDetail.contact
                ])}");
          },
        ),
      ),
    );
  }

  /// 商铺详情
  Widget buildShopDesc() {
    return Visibility(
        visible: TextHelper.isNotEmpty(actuator.shopDetail.about),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Text(
            actuator.shopDetail.about ?? "",
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AppColor.black, fontSize: 14),
          ),
        ));
  }

  /// Follow 关注
  Widget buildFollowButton() {
    return Visibility(
      visible: actuator.shopDetail.followState != null,
      child: actuator.shopDetail.followState == null
          ? Container()
          : GestureDetector(
              child: Container(
                height: 36,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                alignment: Alignment.center,
                decoration: actuator.shopDetail.followState ?? false
                    ? BoxDecoration(
                        color: AppColor.color1A000,
                        borderRadius: BorderRadius.circular(36))
                    : BoxDecoration(
                        border: Border.all(
                            color: AppColor.colorBE, width: AppSizes.divider),
                        borderRadius: BorderRadius.circular(36)),
                child: Text(
                  actuator.shopDetail.followState!
                      ? S.of(context).shopcenter_followed
                      : S.of(context).shopcenter_follow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: actuator.shopDetail.followState ?? false
                          ? AppColor.color81
                          : AppColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                prepareFollowShop();
              },
            ),
    );
  }

  Widget buildProductsHeadline() {
    return Visibility(
        visible: actuator.products != null && actuator.products.isNotEmpty,
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).discover_product,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  /**
   * 构建商铺下的商品列表
   */
  Widget buildShopProducts(BuildContext context) {
    return actuator.isNotNormal()
        ? buildEmptyWidget(context,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.22))
        : GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.68,
            ),
            itemCount: actuator.products.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = actuator.products[index];
            
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: ItemCommonProductBlock(
                    key: Key(
                        "${product.name}-${product.id}-${DateTime.now().microsecond}"),
                    product: product,
                    event: (product) {
                      if (UserManager().isLogin()) {
                        appendShopCart(product);
                      } else {
                        LoginDialog.show(context);
                      }
                    },
                    showOptions: UserManager().delivery(actuator.shopDetail)),
                onTap: () {
                  barController.closeShopCart();
                  Navigator.pushNamed(context, Routes.shopping.ProductDetail,
                      arguments: product.id);
                },
              );
            });
  }
}
