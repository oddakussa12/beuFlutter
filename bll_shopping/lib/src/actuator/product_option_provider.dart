import 'package:common/common.dart';

/**
 * ProductOptionProvider
 * 购物车操作
 *
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ProductOptionProvider {
  bool isCheckedOfProduct(String id) {
    return false;
  }

  /**
   * 选择商铺到预下单列表
   */
  void checkShopProduct(Shop shop, Product product) {
    LogDog.d("checkShopToOrder-shop: ${shop.toJson()}");
    LogDog.d("checkShopToOrder-product: ${product.toJson()}");
  }

  /**
   * 店铺下的商品数量加加
   */
  void addProduct(Product product, Shop shop) {
    LogDog.d("appendProduct-shop: ${shop.toJson()}");
    LogDog.d("appendProduct-product: ${product.toJson()}");
  }

  /**
   * 商铺下的商品数量减减
   */
  void minusProduct(Product product, Shop shop) {
    LogDog.d("minusProduct-shop: ${shop.toJson()}");
    LogDog.d("minusProduct-product: ${product.toJson()}");
  }
}
