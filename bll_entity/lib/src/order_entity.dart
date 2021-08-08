import 'package:json_annotation/json_annotation.dart';
import 'package:origin/origin.dart';

import '../entity.dart';

part 'order_entity.g.dart';

/**
 * RespPromoBody
 * 打折码
 * @author: Ruoyegz
 * @date: 2021/8/7
 */
@JsonSerializable()
class RespPromoBody {
  RespPromoCode? data;

  RespPromoBody({this.data});

  factory RespPromoBody.fromJson(Map<String, dynamic> json) => _$RespPromoBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RespPromoBodyToJson(this);
}

/**
 * RespPromoCode
 * 打折码
 * @author: Ruoyegz
 * @date: 2021/8/7
 */
@JsonSerializable()
class RespPromoCode {
  @JsonKey(name: "promo_code")
  String? promoCode;

  @JsonKey(name: "free_delivery")
  bool? freeDelivery;

  @JsonKey(name: "discount_type")
  String? discountType;

  @JsonKey(name: "percentage")
  double? percentAge;

  String? deadline;
  String? description;

  double? reduction;
  double? limit;


  RespPromoCode(
      this.promoCode,
      this.freeDelivery,
      this.discountType,
      this.percentAge,
      this.deadline,
      this.description,
      this.reduction,
      this.limit);

  factory RespPromoCode.fromJson(Map<String, dynamic> json) =>
      _$RespPromoCodeFromJson(json);

  Map<String, dynamic> toJson() => _$RespPromoCodeToJson(this);
}

/**
 * order_entity.dart
 * 预览订单表
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
@JsonSerializable()
class PreviewOrdersBody {
  /// 状态码：200：显示 message
  /// 0：显示错误消息
  int? code;

  /// promo code 显示消息
  String? message;

  List<PreOrder> data;

  /**
   * 派送地址
   */
  @JsonKey(ignore: true)
  String? name;

  /// 头像
  @JsonKey(ignore: true)
  String? avatar;

  @JsonKey(ignore: true)
  String? phone;

  @JsonKey(ignore: true)
  String? address;

  /// 预览订单的总价
  @JsonKey(ignore: true)
  double? total;

  @JsonKey(ignore: true)
  String? formatTotal;

  /// 1.1.0：订单商品包装费
  @JsonKey(ignore: true)
  double? packageTotal;

  @JsonKey(ignore: true)
  String? formatPackageTotal = "";

  /// 1.1.0：订单商品派送费
  @JsonKey(ignore: true)
  double? deliveryTotal;

  @JsonKey(ignore: true)
  String? formatDeliveryTotal;

  /// 1.1.0：新增
  @JsonKey(ignore: true)
  double? discountTotal;

  @JsonKey(ignore: true)
  String? formatDiscountTotal;

  bool? diffCurrency = false;

  PreviewOrdersBody(this.data,
      {this.name = "",
      this.avatar = "",
      this.phone = "",
      this.address = "",
      this.total = 0.0,
      this.formatTotal = "",
      this.packageTotal = 0.0,
      this.formatPackageTotal = "",
      this.discountTotal = 0.0,
      this.formatDiscountTotal = "",
      this.deliveryTotal = 0.0,
      this.formatDeliveryTotal = "",
      this.diffCurrency = false});

  factory PreviewOrdersBody.fromJson(Map<String, dynamic> json) =>
      _$PreviewOrdersBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewOrdersBodyToJson(this);
}

/**
 * order_entity.dart
 * 预览订单项
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
@JsonSerializable()
class PreOrder {
  final Shop? shop;
  final List<Product>? goods;

  double? subTotal;

  @JsonKey(name: "deliveryCoast")
  double? deliveryCoast;

  String? formatDeliveryCoast = "";

  String? currency;

  String? formatSubTotal = "";

  double? total = 0;

  String? formatTotal = "";

  /// 1.1.0：订单商品包装费
  @JsonKey(name: "packagingCost")
  double? packageFee;

  String? formatPackageFee = "";

  /// 1.1.0：新增
  @JsonKey(name: "subDiscountedTotal")
  double? subDisTotal;

  String? formatSubDisTotal;

  PreOrder(
      {this.shop,
      this.goods,
      this.subTotal = 0.0,
      this.deliveryCoast = 0.0,
      this.packageFee,
      this.currency = "",
      this.formatSubTotal = "",
      this.formatPackageFee = "",
      this.formatDeliveryCoast = "",
      this.subDisTotal = 0.0,
      this.formatSubDisTotal = "",
      this.total = 0.0,
      this.formatTotal = ""});

  factory PreOrder.fromJson(Map<String, dynamic> json) =>
      _$PreOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PreOrderToJson(this);
}

/**
 * order_entity.dart
 * 我的订单表
 *
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
@JsonSerializable()
class MyOrdersBody {
  Metadata? meta;
  Links? links;

  List<Order> data;

  MyOrdersBody(this.data, {this.meta, this.links});

  factory MyOrdersBody.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrdersBodyToJson(this);
}

/**
 * OrderDetailBody
 * 订单详情
 *
 * @author: Ruoyegz
 * @date: 2021/7/4
 */
@JsonSerializable()
class OrderDetailBody {
  Order data;

  OrderDetailBody(this.data);

  factory OrderDetailBody.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailBodyToJson(this);
}

/**
 * order_entity.dart
 * 订单实体
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
@JsonSerializable()
class Order {
  @JsonKey(name: "order_id")
  final String id;

  @JsonKey(name: "user_id")
  String userId;

  @JsonKey(name: "shop_id")
  String shopId;

  int status;

  Shop? shop;

  @JsonKey(name: "user_name")
  String? user;

  @JsonKey(name: "user_contact")
  String? contact;

  @JsonKey(name: "user_address")
  String? address;

  @JsonKey(name: "order_price")
  double? price;

  String? currency;

  // @JsonKey(name: "promo_code")
  // String? promoCode;

  // @JsonKey(name: "discount_type")
  // String? discountType;

  // double? reduction;

  // @JsonKey(name: "discount")
  // double? discount;

  // @JsonKey(name: "discounted_price")
  // double? discountedPrice;

  // @JsonKey(name: "free_delivery")
  // bool? freeDelivery;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "delivery_coast")
  double? coast;

  @JsonKey(name: "detail")
  List<Product>? goods;

  @JsonKey(name: "format_price")
  String? formatPrice = "";

  @JsonKey(ignore: true)
  String? formatCoast = "";

  @JsonKey(ignore: true)
  double? total;

  @JsonKey(ignore: true)
  String? formatTotal = "";

  Order(this.id, this.userId, this.shopId, this.status,
      {this.shop,
      this.user,
      this.contact,
      this.address,
      this.price,
      this.currency,
      this.createdAt,
      this.updatedAt,
      this.coast,
      this.goods,
      this.formatCoast,
      this.formatPrice,
      this.total,
      this.formatTotal});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
