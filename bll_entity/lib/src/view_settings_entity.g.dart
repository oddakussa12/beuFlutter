// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewSettings _$ViewSettingsFromJson(Map<String, dynamic> json) {
  return ViewSettings(
    json['unpopular_restaurant'] as int,
    json['popular_restaurant'] as int,
    json['very_popular_restaurant'] as int,
    json['super_popular_restaurant'] as int,
    json['black_house_restaurant'] as int,
  );
}

Map<String, dynamic> _$ViewSettingsToJson(ViewSettings instance) =>
    <String, dynamic>{
      'unpopular_restaurant': instance.unpopularRestaurant,
      'popular_restaurant': instance.popularRestaurant,
      'very_popular_restaurant': instance.veryPopularRestaurant,
      'super_popular_restaurant': instance.superPopularRestaurant,
      'black_house_restaurant': instance.blackHouseRestaurant,
    };
