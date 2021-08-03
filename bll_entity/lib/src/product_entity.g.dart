// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return ProductList(
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    json['meta'] == null
        ? null
        : Metadata.fromJson(json['meta'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'links': instance.links,
      'meta': instance.meta,
      'data': instance.data,
    };

ProductDetailBody _$ProductDetailBodyFromJson(Map<String, dynamic> json) {
  return ProductDetailBody(
    Product.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductDetailBodyToJson(ProductDetailBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    currency: json['currency'] as String,
    description: json['description'] as String,
    image: (json['image'] as List<dynamic>?)
        ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json['created_at'] as String,
    formatPrice: json['format_price'] as String,
    price: (json['price'] as num).toDouble(),
    averagePoint: (json['average_point'] as num).toDouble(),
    like: json['like'] as int,
    status: json['status'] as int,
    shop: json['user'] == null
        ? null
        : Shop.fromJson(json['user'] as Map<String, dynamic>),
    goodsNumber: json['goodsNumber'] as int?,
    isChecked: json['isChecked'] as bool?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'currency': instance.currency,
      'description': instance.description,
      'image': instance.image,
      'created_at': instance.createdAt,
      'format_price': instance.formatPrice,
      'price': instance.price,
      'average_point': instance.averagePoint,
      'like': instance.like,
      'status': instance.status,
      'goodsNumber': instance.goodsNumber,
      'isChecked': instance.isChecked,
      'user': instance.shop,
    };
