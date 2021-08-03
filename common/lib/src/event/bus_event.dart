

/**
 * bus_client.dart
 * 购物车变化事件
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class ShoppingCartEvent {
  final String shopId;

  ShoppingCartEvent(this.shopId);
}

/**
 * 购物车更新事件
 * 案例：在商铺详情页操作了购物车后，
 * 点击了某个商品详情页操作了购物车
 */
class ShoppingCartUpdateEvent {
  final String shopId;

  ShoppingCartUpdateEvent(this.shopId);
}

class OrderCreatedEvent {}

/// 注册成功
class SignUpEvent {}

/// 登录成功
class SignInEvent {}

/// 退出登录事件
class LogoutEvent {}

/// 更新用户信息
class UpdateUserEvent {

}