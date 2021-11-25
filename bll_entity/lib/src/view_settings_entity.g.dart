// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_settings_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewSettings _$ViewSettingsFromJson(Map<String, dynamic> json) {
  return ViewSettings(
    json['unpopular_restaurant'] as int? ?? 10,
    json['popular_restaurant'] as int? ?? 30,
    json['very_popular_restaurant'] as int? ?? 50,
    json['super_popular_restaurant'] as int? ?? 100,
    json['black_house_restaurant'] as int? ?? 200,
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
