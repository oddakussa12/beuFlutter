// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RespPromoBody _$RespPromoBodyFromJson(Map<String, dynamic> json) {
  return RespPromoBody(
    data: json['data'] == null
        ? null
        : RespPromoCode.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RespPromoBodyToJson(RespPromoBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

RespPromoCode _$RespPromoCodeFromJson(Map<String, dynamic> json) {
  return RespPromoCode(
    json['promo_code'] as String?,
    json['free_delivery'] as bool?,
    json['discount_type'] as String?,
    (json['percentage'] as num?)?.toDouble(),
    json['deadline'] as String?,
    json['description'] as String?,
    (json['reduction'] as num?)?.toDouble(),
    (json['limit'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$RespPromoCodeToJson(RespPromoCode instance) =>
    <String, dynamic>{
      'promo_code': instance.promoCode,
      'free_delivery': instance.freeDelivery,
      'discount_type': instance.discountType,
      'percentage': instance.percentAge,
      'deadline': instance.deadline,
      'description': instance.description,
      'reduction': instance.reduction,
      'limit': instance.limit,
    };

PreviewOrdersBody _$PreviewOrdersBodyFromJson(Map<String, dynamic> json) {
  return PreviewOrdersBody(
    (json['data'] as List<dynamic>)
        .map((e) => PreOrder.fromJson(e as Map<String, dynamic>))
        .toList(),
    diffCurrency: json['diffCurrency'] as bool?,
  )
    ..code = json['code'] as int?
    ..message = json['message'] as String?;
}

Map<String, dynamic> _$PreviewOrdersBodyToJson(PreviewOrdersBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'diffCurrency': instance.diffCurrency,
    };

PreOrder _$PreOrderFromJson(Map<String, dynamic> json) {
  return PreOrder(
    shop: json['shop'] == null
        ? null
        : Shop.fromJson(json['shop'] as Map<String, dynamic>),
    goods: (json['goods'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    subTotal: (json['subTotal'] as num?)?.toDouble(),
    deliveryCoast: (json['deliveryCoast'] as num?)?.toDouble(),
    packageFee: (json['packagingCost'] as num?)?.toDouble(),
    currency: json['currency'] as String?,
    formatSubTotal: json['formatSubTotal'] as String?,
    formatPackageFee: json['formatPackageFee'] as String?,
    formatDeliveryCoast: json['formatDeliveryCoast'] as String?,
    subDisTotal: (json['subDiscountedTotal'] as num?)?.toDouble(),
    formatSubDisTotal: json['formatSubDisTotal'] as String?,
    total: (json['total'] as num?)?.toDouble(),
    formatTotal: json['formatTotal'] as String?,
  );
}

Map<String, dynamic> _$PreOrderToJson(PreOrder instance) => <String, dynamic>{
      'shop': instance.shop,
      'goods': instance.goods,
      'subTotal': instance.subTotal,
      'deliveryCoast': instance.deliveryCoast,
      'formatDeliveryCoast': instance.formatDeliveryCoast,
      'currency': instance.currency,
      'formatSubTotal': instance.formatSubTotal,
      'total': instance.total,
      'formatTotal': instance.formatTotal,
      'packagingCost': instance.packageFee,
      'formatPackageFee': instance.formatPackageFee,
      'subDiscountedTotal': instance.subDisTotal,
      'formatSubDisTotal': instance.formatSubDisTotal,
    };

MyOrdersBody _$MyOrdersBodyFromJson(Map<String, dynamic> json) {
  return MyOrdersBody(
    (json['data'] as List<dynamic>)
        .map((e) => Order.fromJson(e as Map<String, dynamic>))
        .toList(),
    meta: json['meta'] == null
        ? null
        : Metadata.fromJson(json['meta'] as Map<String, dynamic>),
    links: json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyOrdersBodyToJson(MyOrdersBody instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'links': instance.links,
      'data': instance.data,
    };

OrderDetailBody _$OrderDetailBodyFromJson(Map<String, dynamic> json) {
  return OrderDetailBody(
    Order.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderDetailBodyToJson(OrderDetailBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['order_id'] as String,
    json['user_id'] as String,
    json['shop_id'] as String,
    json['status'] as int,
    shop: json['shop'] == null
        ? null
        : Shop.fromJson(json['shop'] as Map<String, dynamic>),
    user: json['user_name'] as String?,
    contact: json['user_contact'] as String?,
    address: json['user_address'] as String?,
    price: (json['order_price'] as num?)?.toDouble(),
    currency: json['currency'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    coast: (json['delivery_coast'] as num?)?.toDouble(),
    goods: (json['detail'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    formatPrice: json['format_price'] as String?,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'order_id': instance.id,
      'user_id': instance.userId,
      'shop_id': instance.shopId,
      'status': instance.status,
      'shop': instance.shop,
      'user_name': instance.user,
      'user_contact': instance.contact,
      'user_address': instance.address,
      'order_price': instance.price,
      'currency': instance.currency,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'delivery_coast': instance.coast,
      'detail': instance.goods,
      'format_price': instance.formatPrice,
    };
