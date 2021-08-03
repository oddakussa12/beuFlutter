// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewOrdersBody _$PreviewOrdersBodyFromJson(Map<String, dynamic> json) {
  return PreviewOrdersBody(
    (json['data'] as List<dynamic>)
        .map((e) => PreOrder.fromJson(e as Map<String, dynamic>))
        .toList(),
    diffCurrency: json['diffCurrency'] as bool?,
  );
}

Map<String, dynamic> _$PreviewOrdersBodyToJson(PreviewOrdersBody instance) =>
    <String, dynamic>{
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
    coast: (json['deliveryCoast'] as num?)?.toDouble(),
    packageFee: (json['packagingCost'] as num?)?.toDouble(),
    currency: json['currency'] as String?,
  );
}

Map<String, dynamic> _$PreOrderToJson(PreOrder instance) => <String, dynamic>{
      'shop': instance.shop,
      'goods': instance.goods,
      'subTotal': instance.subTotal,
      'deliveryCoast': instance.coast,
      'packagingCost': instance.packageFee,
      'currency': instance.currency,
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
