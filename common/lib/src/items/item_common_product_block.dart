import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 添加商品事件【将商品添加到购物车】
typedef AppendProductEvent = void Function(Product product);

/**
 * ItemCommonProductBlock
 * 商品表格 item
 *
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class ItemCommonProductBlock extends StatefulWidget {
  /// 商品信息
  final Product product;

  /// 是否展示购物
  final bool showOptions;

  /// 添加购物车事件
  final AppendProductEvent? event;

  const ItemCommonProductBlock(
      {Key? key, required this.product, required this.showOptions, this.event})
      : super(key: key);

  @override
  _ItemCommonProductBlockState createState() => _ItemCommonProductBlockState();
}

class _ItemCommonProductBlockState extends State<ItemCommonProductBlock> {
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
              buildProductImage(widget.product, context),

              /// 添加购物车
              Positioned(
                child: buildAddCartIcon(widget.product, widget.showOptions),
                right: 8,
                bottom: 8,
              ),

              /// 商品星
              Positioned(
                child: buildProductStars(widget.product),
                bottom: 8,
                left: 8,
              ),
            ],
          ),

          /// 商品价格
         Row(
           children: [
              buildProductPrice(widget.product),

          ///商品折扣价
   widget.product.discountPrice! >0? buildProductDiscountPrice(widget.product ):Container(),
           ],
         ),

          /// 商品标题
          buildProductTitle(widget.product),
        ],
      ),
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
                height: MediaQuery.of(context).size.width / 2 - 32,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width / 2),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_cover_1_1.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 2 - 32,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width / 2),
            height: MediaQuery.of(context).size.width / 2 - 32,
            width: MediaQuery.of(context).size.width / 2,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建添加购物车图标
   */
  Widget buildAddCartIcon(Product product, bool showOptions) {
    return Offstage(
      offstage: !showOptions,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Image.asset(
          "res/icons/ic_add_cart.png",
          package: 'resources',
          width: 26,
          height: 26,
          fit: BoxFit.cover,
        ),
        onTap: () {
          if (widget.event != null) {
            widget.event!.call(product);
          }
        },
      ),
    );
  }

  /**
   * 商铺评分
   */
  Widget buildProductStars(Product product) {
    int star = product.averagePoint!.toInt();
    if (star <= 0) {
      return Container();
    }

    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(buildProductStar(star >= i));
    }
    return Container(
      height: 26,
      width: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColor.color80000, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: stars,
      ),
    );
  }

  Widget buildProductStar(bool isLight) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 1),
        child: Image.asset(
          isLight
              ? "res/icons/ic_star_light.png"
              : "res/icons/ic_star_dark.png",
          package: 'resources',
          width: 12,
          height: 12,
        ));
  }

  /**
   * 商品价格【折扣价】官方分类
   */
  Widget buildProductPrice(Product product) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 8, left: 5, right: 5),
          child: Text(
            /// 是官方分类则此处显示原价并加删除线
            TextHelper.clean(product.formatPrice),
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                decoration:product.discountPrice! >0 
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 2,
                color: AppColor.colorBE,
                fontSize: 12,
                fontWeight: FontWeight.bold,
               
                
                ),
          ),
        ),
        // (product.discountPrice?? 0)!= 0?  Container(
        //   alignment: Alignment.centerLeft,
        //   margin: EdgeInsets.only(top: 8, left: 5, right: 5),
        //   child: Text(
        //     /// 是官方分类则此处显示原价并加删除线
        //     TextHelper.clean(product.discountPrice.toString()),
        //     textAlign: TextAlign.left,
        //     maxLines: 1,
        //     overflow: TextOverflow.ellipsis,
        //     style: TextStyle(
        //         decoration: product.isGFCategory()
        //             ? TextDecoration.lineThrough
        //             : TextDecoration.none,
        //         decorationThickness: 2,
        //         color: AppColor.colorBE,
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold),
        //   ),
        // ):Container()
      ],
    );
  }

  /**
   * 商品价格
   */

  Widget buildProductDiscountPrice(Product product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 8, left: 5, right: 5),
      child: Text(
        "${product.discountPrice}${product.currency}",
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.colorF7551D,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }
  // Widget buildProductDiscountPrice(Product product) {
  //   return Offstage(
  //     offstage: !product.isGFCategory(),
  //     child: Container(
  //       alignment: Alignment.centerLeft,
  //       margin: EdgeInsets.only(top: 6, left: 5, right: 5),
  //       child: Text(
  //         TextHelper.clean(product.discountPrice.toString()),
  //         textAlign: TextAlign.left,
  //         maxLines: 1,
  //         overflow: TextOverflow.ellipsis,
  //         style: TextStyle(
  //             color: AppColor.colorBE,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //   );
  // }

  /**
   * 商品名称
   */
  Widget buildProductTitle(Product product) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6, left: 2, right: 2),
      child: Text(
        product.name ?? "",
        textAlign: TextAlign.left,
        maxLines: product.isGFCategory() ? 1 : 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: AppColor.color0F0F17,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
