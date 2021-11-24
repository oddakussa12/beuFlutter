import 'package:common/common.dart';
import 'package:shopping/src/widget/cart/shopping_cart_bar.dart';

/**
 * shopping_cart_bar.dart
 * 购物车控制器
 * @author: Ruoyegz
 * @date: 2021/7/12
 */
class ShoppingCartBarController {
  late ShoppingCartBarState _barState;

  void initController(ShoppingCartBarState state) {
    _barState = state;
  }

  ShoppingCart? getShoppingCart() {
    return _barState != null ? _barState.actuator.shopCart : null;
  }

  void forceRefresh() {
    if (_barState != null) {
      _barState.actuator.isNeedRefreshCart = true;
      _barState.actuator.loadMyShopCart();
    }
  }

  void refreshShoppingCart() {
    if (_barState != null) {
      _barState.actuator.loadMyShopCart();
    }
  }

  void closeShopCart() {
    if (_barState != null && !_barState.showProducts) {
      _barState.toggle();
    }
  }

  void toggleShoppingCart() {
    if (_barState != null) {
      _barState.toggle();
    }
  }

  void outsideAddProduct(Product product, Shop shop) {
    if (_barState != null) {
      _barState.outsideAddProduct(product, shop);
    }
  }

  void minusProduct(Product product, Shop shop) {
    if (_barState != null) {
      _barState.minusProduct(product, shop);
    }
  }
}
