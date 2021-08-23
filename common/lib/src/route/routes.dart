/**
 * routes.dart
 * 全局的路由表配置
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class Routes {
  static final common = _Common();
  static final discover = _Discover();
  static final shopping = _Shopping();
  static final special = _Special();
  static final centre = _Centre();
  static final address = _Address();
}

/**
 * _Common
 * 通用
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
class _Common {
  static final String _Module = "Common/";

  /// 通用浏览器页面
  final String WebPage = _Module + "WebPage";
}

/**
 * Discover Module
 * 发现
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class _Discover {
  static final String _Module = "Discover/";

  /// 发现页商铺列表
  final String Shops = _Module + "Shops";

  /// 发现页商品列表
  final String Products = _Module + "Products";
}

/**
 * Shopping
 * 购物
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class _Shopping {
  static final String _Module = "Shopping/";

  /// 商品详情
  final String ProductDetail = _Module + "ProductDetail";

  /// 商铺详情
  final String ShopDetail = _Module + "ShopDetail";

  /// 订单预览
  final String OrderPreview = _Module + "OrderPreview";

  /// 我的订单
  final String MyOrder = _Module + "MyOrder";

  /// 派送地址
  final String DeliveryAddress = _Module + "DeliveryAddress";

  /// 订单详情
  final String OrderDetail = _Module + "OrderDetail";
}

class _Special {
  static final String _Module = "Shopping/";

  /// 订单详情
  final String SpecialProducts = _Module + "SpecialProducts";
}

/**
 * _Centre
 * 用户中心
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
class _Centre {
  static final String _Module = "Centre/";

  /// 登录
  final String Login = _Module + "Login";

  /// 注册
  final String Register = _Module + "Register";

  /// 选择国家区号
  final String CountryCode = _Module + "CountryCode";

  /// 关注的商铺
  final String FollowShops = _Module + "FollowShops";
}

class _Address {
  static final String _Module = "Address/";

  /// 地址薄
  final String AddressBook = _Module + "AddressBook";

  /// 地址编辑器
  final String AddressEditor = _Module + "AddressEditor";

  /// 地址定位
  final String AddressLocation = _Module + "AddressLocation";
}
