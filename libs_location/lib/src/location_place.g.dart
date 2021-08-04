// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationPlace _$LocationPlaceFromJson(Map<String, dynamic> json) {
  return LocationPlace(
    type: json['type'] as String?,
    query: (json['query'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList(),
    features: (json['features'] as List<dynamic>?)
        ?.map((e) => Features.fromJson(e))
        .toList(),
  );
}

Map<String, dynamic> _$LocationPlaceToJson(LocationPlace instance) =>
    <String, dynamic>{
      'type': instance.type,
      'query': instance.query,
      'features': instance.features,
    };

Features _$FeaturesFromJson(Map<String, dynamic> json) {
  return Features(
    id: json['id'] as String?,
    type: json['type'] as String?,
    placeType: (json['place_type'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    relevance: json['relevance'] as int?,
    properties: json['properties'] == null
        ? null
        : Properties.fromJson(json['properties']),
    text: json['text'] as String?,
    placeName: json['place_name'] as String?,
  );
}

Map<String, dynamic> _$FeaturesToJson(Features instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'relevance': instance.relevance,
      'place_type': instance.placeType,
      'text': instance.text,
      'place_name': instance.placeName,
      'properties': instance.properties,
    };

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  return Properties(
    foursquare: json['foursquare'] as String?,
    landmark: json['landmark'] as bool?,
    address: json['address'] as String?,
    category: json['category'] as String?,
  );
}

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'foursquare': instance.foursquare,
      'landmark': instance.landmark,
      'address': instance.address,
      'category': instance.category,
    };
