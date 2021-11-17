import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * ItemSpecialProductWidget
 *
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class ItemSpecialProductWidget extends StatelessWidget {
  /// 商品信息
  final SpecProduct product;

  /// 是否展示购物
  final bool showOptions;

  const ItemSpecialProductWidget(
      {Key? key, required this.product, required this.showOptions})
      : super(key: key);

  void prepareOrderPreview(BuildContext context) {
    if (UserManager().isLogin()) {
      if (product != null) {
        Map<String, String> idNumbers = {};
        idNumbers["${product.id}"] = "1";
        Navigator.pushNamed(context, Routes.shopping.OrderPreview,
            arguments: {"goods": idNumbers, "type": "special"});
      }
    } else {
      LoginDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(24)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            /// 商品图片
            buildProductImage(product, context),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      /// 商品价格
                      buildProductPrice(product),

                      buildProductSpecialPrice(product),
                    ],
                  ),

                  /// 商品标题
                  buildProductTitle(product),

                  /// 商品星
                  // buildProductStars(product),

                  /// 商铺信息
                  buildShopInfo(context),
                ],
              ),
            )
          ],
        ));
  }

  /**
   * 构建商铺背景
   */
  Widget buildProductImage(SpecProduct product, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(product.image![0].url),
            placeholder: (context, url) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                gaplessPlayback: true,
                height: MediaQuery.of(context).size.width - 32,
                width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                gaplessPlayback: true,
                height: MediaQuery.of(context).size.width - 32,
                width: MediaQuery.of(context).size.width),
            height: MediaQuery.of(context).size.width - 32,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 商品价格
   */
  Widget buildProductPrice(SpecProduct product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 16, left: 16),
      child: Text(
        TextHelper.clean(product.formatPrice),
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.colorBE,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.lineThrough),
      ),
    );
  }

  /// 商品特价
  Widget buildProductSpecialPrice(SpecProduct product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 16, left: 16),
      child: Text(
        "${product.specialPrice}${product.currency}",
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.colorF7551D,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  /**
   * 商品名称
   */

  Widget buildProductTitle(SpecProduct product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Text(
        product.description!,
        maxLines: 2,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.color0F0F17,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  /**
   * 商铺评分
   */
  Widget buildProductStars(SpecProduct product) {
    List<Widget> stars = [];
    int star = product.averagePoint!.toInt();

    for (int i = 1; i <= 5; i++) {
      stars.add(buildProductStar(star >= i));
    }
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
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
            width: 13,
            height: 13,
          ));
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        child: Image.asset("res/icons/ic_star_dark.png",
            package: 'resources', width: 13, height: 13),
      );
    }
  }

  Widget buildShopInfo(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 12, right: 16, bottom: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 2),
            child: Image.asset(
              "res/icons/ic_market_place.png",
              package: 'resources',
              width: 25,
              height: 25,
            )),

        /// 商铺标题
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 8, bottom: 2),
            child: Text(
              TextHelper.clean(
                  product.shop != null ? product.shop!.nickName : ""),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        /// 购物车
        GestureDetector(
          child: Image.asset(
            "res/icons/ic_big_shopping.png",
            package: 'resources',
            width: 44,
            height: 44,
          ),
          onTap: () {
            prepareOrderPreview(context);
          },
        )
      ]),
    );
  }
}
