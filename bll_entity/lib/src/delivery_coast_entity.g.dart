// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_coast_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqDeliveryCoastBody _$ReqDeliveryCoastBodyFromJson(Map<String, dynamic> json) {
  return ReqDeliveryCoastBody(
    (json['location'] as List<dynamic>)
        .map((e) => DeliveryParam.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ReqDeliveryCoastBodyToJson(
        ReqDeliveryCoastBody instance) =>
    <String, dynamic>{
      'location': instance.location,
    };

DeliveryParam _$DeliveryParamFromJson(Map<String, dynamic> json) {
  return DeliveryParam(
    json['shop_id'] as String,
    (json['start'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
  );
}

Map<String, dynamic> _$DeliveryParamToJson(DeliveryParam instance) =>
    <String, dynamic>{
      'shop_id': instance.shop_id,
      'start': instance.start,
    };

DeliveryCoastBody _$DeliveryCoastBodyFromJson(Map<String, dynamic> json) {
  return DeliveryCoastBody(
    (json['data'] as List<dynamic>)
        .map((e) => DeliveryCoast.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DeliveryCoastBodyToJson(DeliveryCoastBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DeliveryCoast _$DeliveryCoastFromJson(Map<String, dynamic> json) {
  return DeliveryCoast(
    start: json['start'] == null
        ? null
        : Coordinate.fromJson(json['start'] as Map<String, dynamic>),
    end: json['end'] == null
        ? null
        : Coordinate.fromJson(json['end'] as Map<String, dynamic>),
    shopId: json['shopId'] as String?,
    distance: (json['distance'] as num?)?.toDouble(),
    deliveryCost: (json['deliveryCost'] as num?)?.toDouble(),
    currency: json['currency'] as String?,
  );
}

Map<String, dynamic> _$DeliveryCoastToJson(DeliveryCoast instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'shopId': instance.shopId,
      'distance': instance.distance,
      'deliveryCost': instance.deliveryCost,
      'currency': instance.currency,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) {
  return Coordinate(
    location: (json['location'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList(),
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
    };
