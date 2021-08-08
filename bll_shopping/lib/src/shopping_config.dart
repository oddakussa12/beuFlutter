/**
 * shopping_config.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ShoppingUrl {
  /// 商铺详情
  static final String productDetail = "/api/goods/";

  /// 商品列表
  static final String products = "/api/goods";

  /// 操作购物车
  static final String optionCart = "/api/shopping_cart";

  /// 订单预览
  static final String orderPreview = "/api/order/preview";

  /// 订单相关 api
  static final String apiOrder = "/api/order";

  /// 我的订单
  static final String myOrders = "/api/order/myself";

  /// 获取用户信息
  static final String getUserInfo = "/api/user/";

  /// 计算配送费用
  static final String calcDeliveryCost = "/api/business/delivery_cost";

  /// 促销码查询
  static String promoCode(String promo) => "/api/promo_code/${promo}";

  static final String followShop = "/api/follow";
}
