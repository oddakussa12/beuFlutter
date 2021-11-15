// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowShopEntity _$FollowShopEntityFromJson(Map<String, dynamic> json) {
  return FollowShopEntity(
    data: (json['data'] as List<dynamic>)
        .map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FollowShopEntityToJson(FollowShopEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DiscoverShopEntity _$DiscoverShopEntityFromJson(Map<String, dynamic> json) {
  return DiscoverShopEntity(
    liveShops: (json['live_shop'] as List<dynamic>)
        .map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
    deliveryShops: (json['delivery_shop'] as List<dynamic>)
        .map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DiscoverShopEntityToJson(DiscoverShopEntity instance) =>
    <String, dynamic>{
      'live_shop': instance.liveShops,
      'delivery_shop': instance.deliveryShops,
    };

ShoppingCart _$ShoppingCartFromJson(Map<String, dynamic> json) {
  return ShoppingCart(
    (json['data'] as List<dynamic>)
        .map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShoppingCartToJson(ShoppingCart instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ShopDetail _$ShopDetailFromJson(Map<String, dynamic> json) {
  return ShopDetail(
    Shop.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShopDetailToJson(ShopDetail instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ShopList _$ShopListFromJson(Map<String, dynamic> json) {
  return ShopList(
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    json['meta'] == null
        ? null
        : Metadata.fromJson(json['meta'] as Map<String, dynamic>),
    (json['data'] as List<dynamic>)
        .map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShopListToJson(ShopList instance) => <String, dynamic>{
      'links': instance.links,
      'meta': instance.meta,
      'data': instance.data,
    };

DiscoveryShopBody _$DiscoveryShopBodyFromJson(Map<String, dynamic> json) {
  return DiscoveryShopBody(
    json['links'] == null
        ? null
        : Links.fromJson(json['links'] as Map<String, dynamic>),
    json['meta'] == null
        ? null
        : Metadata.fromJson(json['meta'] as Map<String, dynamic>),
    DiscoveryShops.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DiscoveryShopBodyToJson(DiscoveryShopBody instance) =>
    <String, dynamic>{
      'links': instance.links,
      'meta': instance.meta,
      'data': instance.data,
    };

DiscoveryShops _$DiscoveryShopsFromJson(Map<String, dynamic> json) {
  return DiscoveryShops(
    (json['live_shop'] as List<dynamic>?)
        ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['delivery_shop'] as List<dynamic>?)
        ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DiscoveryShopsToJson(DiscoveryShops instance) =>
    <String, dynamic>{
      'live_shop': instance.lives,
      'delivery_shop': instance.deliveries,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) {
  // double? days = (sec) / (24 * 3600);
  // double? hours = (( (json['deliveryTime'] as num?)?.toDouble())! % (24 * 3600)) / 3600;
  // double? minutes = ((sec) % (24 * 3600 * 3600)) / 60;
  // double? seconds = ((sec) % (24 * 3600 * 3600 * 60)) / 60;
  
  return Shop(
    json['user_id'] as String,
    uuid: json['user_uuid'] as String?,
    name: json['user_name'] as String?,
    nickName: json['user_nick_name'] as String?,
    country: json['user_country'] as String?,
    birthday: json['user_birthday'] as String?,
    about: json['user_about'] as String?,
    school: json['user_school'] as String?,
    sl: json['user_sl'] as String?,
    grade: json['user_grade'] as String?,
    contact: json['user_contact'] as String?,
    address: json['user_address'] as String?,
    enrollmentAt: json['user_enrollment_at'] as String?,
    gender: json['user_gender'] as int?,
    level: json['user_level'] as int?,
    shop: json['user_shop'] as int?,
    answer: json['user_answer'] as int?,
    activation: json['user_activation'] as int?,
    isFriend: json['isFriend'] as bool?,
    delivery: json['user_delivery'] as bool?,
    followState: json['followState'] as bool?,
    userPoint: json['userPoint'] == null
        ? null
        : UserPoint.fromJson(json['userPoint']),
    deliveryTime: (json['deliveryTime'] as num?)?.toDouble(),
    distance:(json['distance'] as num?)?.toDouble(),
    orderCount:486 as int? ,
    averagePrice:(75 as num?)?.toDouble() ,
    // orderCount:(json['orderCount'] as int?) ,
    // averagePrice:(json['averagePrice'] as num?)?.toDouble(),
    currency: json['user_currency'] as String?,
    coast: (json['deliveryCoast'] as num?)?.toDouble(),
    subTotal: (json['subTotal'] as num?)?.toDouble(),
    goods: (json['goods'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    bg: json['user_bg'] as String?,
    avatarLink: json['user_avatar_link'] as String?,
    callCenter: json['callCenter'] as String?,
    isChecked: json['isChecked'] as bool?,
  )
    ..friendCount = json['friendCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..likeState = json['likeState'] as bool?
    ..rank = (json['rank'] as num?)?.toDouble()
    ..score = (json['score'] as num?)?.toDouble();
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'user_id': instance.id,
      'user_uuid': instance.uuid,
      'user_name': instance.name,
      'user_nick_name': instance.nickName,
      'user_country': instance.country,
      'user_bg': instance.bg,
      'user_birthday': instance.birthday,
      'user_about': instance.about,
      'user_school': instance.school,
      'user_sl': instance.sl,
      'user_grade': instance.grade,
      'user_contact': instance.contact,
      'callCenter': instance.callCenter,
      'user_address': instance.address,
      'user_enrollment_at': instance.enrollmentAt,
      'user_avatar_link': instance.avatarLink,
      'user_gender': instance.gender,
      'user_level': instance.level,
      'user_shop': instance.shop,
      'user_answer': instance.answer,
      'user_activation': instance.activation,
      'user_delivery': instance.delivery,
      'userPoint': instance.userPoint,
      'user_currency': instance.currency,
      'deliveryCoast': instance.coast,
      'subTotal': instance.subTotal,
      'goods': instance.goods,
      'friendCount': instance.friendCount,
      'likedCount': instance.likedCount,
      'isFriend': instance.isFriend,
      'likeState': instance.likeState,
      'followState': instance.followState,
      'rank': instance.rank,
      'score': instance.score,
      'isChecked': instance.isChecked,
    };
