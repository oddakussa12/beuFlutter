import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'view_settings_entity.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class ViewSettings {
  ViewSettings(
      this.unpopularRestaurant,
      this.popularRestaurant,
      this.veryPopularRestaurant,
      this.superPopularRestaurant,
      this.blackHouseRestaurant);

  @JsonKey(name: 'unpopular_restaurant', defaultValue: 10)
  final int unpopularRestaurant;

  @JsonKey(name: 'popular_restaurant', defaultValue: 30)
  final int popularRestaurant;

  @JsonKey(name: 'very_popular_restaurant', defaultValue: 50)
  final int veryPopularRestaurant;

  @JsonKey(name: 'super_popular_restaurant', defaultValue: 100)
  final int superPopularRestaurant;

  @JsonKey(name: 'black_house_restaurant', defaultValue: 200)
  final int blackHouseRestaurant;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ViewSettings.fromJson(Map<String, dynamic> json) => json.isNotEmpty
      ? _$ViewSettingsFromJson(json)
      : ViewSettings(10, 30, 50, 100, 200);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ViewSettingsToJson(this);
}
