import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';

/**
 * item_my_bag_product.dart
 * 购物车商品下商品项
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ItemMyBagProductWidget extends StatefulWidget {
  final Shop shop;

  /// 商铺信息
  final Product product;
  final ProductOptionProvider provider;

  const ItemMyBagProductWidget(
      {Key? key,
      required this.shop,
      required this.product,
      required this.provider})
      : super(key: key);

  @override
  _ItemMyBagProductState createState() => _ItemMyBagProductState();
}

class _ItemMyBagProductState extends State<ItemMyBagProductWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return Container();
    }
    if (widget.product.isChecked == null) {
      widget.product.isChecked = false;
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// 购物车商品选择
          buildCartProductCheck(),

          /// 购物车商品图片
          buildCartProductImage(),

          /// 购物车商品信息
          buildProductPriceInfo(),

          /// 购物车商品加减操作
          buildProductOptions()
        ],
      ),
    );
  }

  /**
   * 购物车商品选择
   */
  Widget buildCartProductCheck() {
    return Container(
      width: 20,
      height: 60,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Checkbox(
          value: widget.product.isChecked,
          activeColor: AppColor.colorF7551D,
          onChanged: (checked) {
            widget.product.isChecked = checked;
            if (checked! && !widget.shop.isChecked!) {
              widget.shop.isChecked = checked;
            }
            if (widget.provider != null) {
              widget.provider.checkShopProduct(widget.shop, widget.product);
            }
          }),
    );
  }

  /**
   * 购物车商品图片
   */
  ClipRRect buildCartProductImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 50),
          fadeOutDuration: const Duration(milliseconds: 50),
          imageUrl: widget.product.productImage(),
          placeholder: (context, url) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 64,
              gaplessPlayback: true,
              width: 64),
          errorWidget: (context, url, error) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 64,
              gaplessPlayback: true,
              width: 64),
          height: 64,
          width: 64,
          fit: BoxFit.cover,
        ));
  }

  /**
   * 购物车商品信息
   */
  Widget buildProductPriceInfo() {
    return Expanded(
        child: Container(
          height: 64,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    TextHelper.clean(widget.product.name),
                    maxLines: widget.product.isGFCategory() ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColor.color0F0F17, fontSize: 14),
                  )),

              /// 商品原价
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    TextHelper.clean(widget.product.discountPrice.toString()+ " "+ widget.product.currency.toString()),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColor.colorBE,
                        fontSize: 16,
                        decoration: widget.product.isGFCategory()
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 2),
                  )),

              /// 官方分类下的商品展示折扣价
              Visibility(
                visible: widget.product.isGFCategory(),
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      TextHelper.clean(widget.product.formatDisPrice),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.colorBE, fontSize: 16),
                    )),
              ),
            ],
          ),
        ));
  }

  /**
   * 购物车商品加减操作
   */
  Container buildProductOptions() {
    return Container(
      alignment: Alignment.bottomRight,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: IconButton(
                onPressed: () {
                  if (widget.provider != null) {
                    widget.provider.minusProduct(widget.product, widget.shop);
                  }
                },
                icon: Image.asset(
                  "res/icons/ic_option_minus.png",
                  package: 'resources',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
              height: 24,
              width: 27,
              alignment: Alignment.center,
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.only(left: 1, right: 1),
              decoration: BoxDecoration(
                color: AppColor.white,
              ),
              child: Text(
                "${widget.product.goodsNumber}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: IconButton(
                  onPressed: () {
                    if (widget.provider != null) {
                      widget.provider.addProduct(widget.product, widget.shop);
                    }
                  },
                  icon: Image.asset(
                    "res/icons/ic_option_add.png",
                    package: 'resources',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  )))
        ],
      ),
    );
  }
}
