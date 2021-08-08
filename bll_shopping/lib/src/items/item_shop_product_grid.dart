import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 添加商品事件【将商品添加到购物车】
typedef AppendProductEvent = void Function(Product product);

/**
 * item_product_grid.dart
 * 商品表格 item
 *
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class ItemShopProductGridWidget extends StatefulWidget {
  /// 商品信息
  final Product product;

  /// 是否展示购物
  final bool showOptions;

  /// 添加购物车事件
  final AppendProductEvent event;

  const ItemShopProductGridWidget(
      {Key? key,
      required this.product,
      required this.showOptions,
      required this.event})
      : super(key: key);

  @override
  _ItemShopProductGridWidgetState createState() =>
      _ItemShopProductGridWidgetState();
}

class _ItemShopProductGridWidgetState extends State<ItemShopProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
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
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.shopping.ProductDetail,
            arguments: widget.product.id);
      },
    );
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
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
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
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      child: Container(
          padding: EdgeInsets.all(13),
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(top: 100, bottom: 0, right: 0),
          child: Image.asset(
            "res/icons/ic_add_cart.png",
            package: 'resources',
            width: 26,
            height: 26,
            fit: BoxFit.cover,
          )),
      onTap: () {
        if (widget.event != null) {
          widget.event.call(product);
        }
      },
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
        style: TextStyle(
            color: AppColor.hint, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ));
  }

  /**
   * 商铺评分
   */
  Widget buildProductStars(Product product) {
    List<Widget> stars = [];
    int star = product.averagePoint!.toInt();

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
        product.name!,
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.h1, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
