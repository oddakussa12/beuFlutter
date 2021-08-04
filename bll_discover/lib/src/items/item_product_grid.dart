import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * ItemProductGridWidget
 *
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class ItemProductGridWidget extends StatelessWidget {
  /// 商品信息
  final Product product;

  /// 是否展示购物
  final bool showOptions;

  const ItemProductGridWidget(
      {Key? key, required this.product, required this.showOptions})
      : super(key: key);

  /**
   * 将商品添加到购物车
   */
  void appendShopCart(Product product) {
    LogDog.d("appendShopCart: ${product.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                /// 商品图片
                buildProductImage(product, context),

                /// 添加购物车
                buildAddCartIcon(product, showOptions)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                /// 商品价格
                buildProductPrice(product),

                /// 商品星
                buildProductStars(product),
              ],
            ),

            /// 商品标题
            buildProductTitle(product),
          ],
        ));
  }

  /**
   * 构建商铺背景
   */
  Widget buildProductImage(Product product, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 100),
            imageUrl: TextHelper.clean(product.image![0].url),
            placeholder: (context, url) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 150,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width / 2),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 150,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width / 2),
            height: 150,
            width: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建添加购物车图标
   */
  Widget buildAddCartIcon(Product product, bool showOptions) {
    if (!showOptions) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(top: 114, bottom: 4, right: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Image.asset(
          "res/icons/ic_add_cart.png",
          package: 'resources',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        onTap: () {
          appendShopCart(product);
        },
      ),
    );
  }

  /**
   * 商品价格
   */
  Widget buildProductPrice(Product product) {
    return Expanded(
        child: Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Text(
        TextHelper.clean(product.formatPrice),
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColor.hint, fontSize: 14),
      ),
    ));
  }

  /**
   * 商铺评分
   */
  Widget buildProductStars(Product product) {
    List<Widget> stars = [];
    int star = product.averagePoint.toInt();

    for (int i = 1; i <= 5; i++) {
      stars.add(buildProductStar(star >= i));
    }
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: stars,
      ),
    );
  }

  Widget buildProductStar(bool isLight) {
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
        child: Image.asset("res/icons/ic_star_dark.png",
            package: 'resources', width: 10, height: 10),
      );
    }
  }

  /**
   * 商品名称
   */
  Widget buildProductTitle(Product product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Text(
        product.name,
        textAlign: TextAlign.left,
        maxLines: PlatformSupport.ios() ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColor.h1, fontSize: 16),
      ),
    );
  }
}

/**
 * item_product_grid.dart
 * 商品表格 item
 *
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
/*class ItemProductGridWidget extends StatefulWidget {
  /// 商品信息
  final Product product;

  /// 是否展示购物
  final bool showOptions;

  const ItemProductGridWidget(
      {Key? key, required this.product, required this.showOptions})
      : super(key: key);

  @override
  _ItemProductGridWidgetState createState() => _ItemProductGridWidgetState();
}

class _ItemProductGridWidgetState extends State<ItemProductGridWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  */ /**
      * 将商品添加到购物车
      */ /*
  void appendShopCart(Product product) {
    LogDog.d("appendShopCart: ${product.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                /// 商品图片
                buildProductImage(widget.product, context),

                /// 添加购物车
                buildAddCartIcon(widget.product, widget.showOptions)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                /// 商品价格
                buildProductPrice(widget.product),

                /// 商品星
                buildProductStars(widget.product),
              ],
            ),

            /// 商品标题
            buildProductTitle(widget.product),
          ],
        ));
  }

  Container buildProductImageByCache(Product product, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 100),
            imageUrl: TextHelper.clean(product.image![0].url),
            placeholder: (context, url) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 150,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 150,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            height: 150,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  */ /**
               * 构建商铺背景
               */ /*
  Container buildProductImage(Product product, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FadeInImage.assetNetwork(
            placeholder: "packages/resources/res/images/def_cover_1_1.png",
            image: product.image![0].url,
            height: 150,
            fadeInDuration: const Duration(milliseconds: 100),
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 150,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
        ));
  }

  */ /**
                        * 构建添加购物车图标
                        */ /*
  Widget buildAddCartIcon(Product product, bool showOptions) {
    if (!showOptions) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(top: 114, bottom: 4, right: 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Image.asset(
          "res/icons/ic_add_cart.png",
          package: 'resources',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        onTap: () {
          appendShopCart(product);
        },
      ),
    );
  }

  */ /**
                                 * 商品价格
                                 */ /*
  Widget buildProductPrice(Product product) {
    return Expanded(
        child: Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Text(
        TextHelper.clean(product.formatPrice),
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColor.hint, fontSize: 14),
      ),
    ));
  }

  */ /**
                                          * 商铺评分
                                          */ /*
  Widget buildProductStars(Product product) {
    List<Widget> stars = [];
    int star = product.averagePoint.toInt();

    for (int i = 1; i <= 5; i++) {
      stars.add(buildProductStar(star >= i));
    }
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: stars,
      ),
    );
  }

  Widget buildProductStar(bool isLight) {
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
        child: Image.asset("res/icons/ic_star_dark.png",
            package: 'resources', width: 10, height: 10),
      );
    }
  }

  */ /**
                                                   * 商品名称
                                                   */ /*
  Widget buildProductTitle(Product product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 5),
      child: Text(
        product.name,
        textAlign: TextAlign.left,
        maxLines: PlatformSupport.ios() ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: AppColor.h1, fontSize: 16),
      ),
    );
  }
}*/
