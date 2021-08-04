import 'package:common/common.dart';

part 'location_place.g.dart';

/// type : "FeatureCollection"
/// query : [116.2869056,40.058601]
/// features : [{"id":"poi.94489387011","type":"Feature","place_type":["poi"],"relevance":1,"properties":{"foursquare":"4b9483a4f964a520047c34e3","landmark":true,"address":"海淀区","category":"coworking space, office"},"text":"联想研发大厦","place_name":"联想研发大厦, 海淀区, Beijing Shi, 100094, China","center":[116.292259,40.052],"geometry":{"coordinates":[116.292259,40.052],"type":"Point"},"context":[{"id":"postcode.17697725104443630","text":"100094"},{"id":"locality.13188648206299350","wikidata":"Q393454","text":"Haidian Qu"},{"id":"place.11643701859936750","wikidata":"Q956","text":"Beijing Shi"},{"id":"country.2656715919","wikidata":"Q148","short_code":"cn","text":"China"}]},{"id":"postcode.17697725104443630","type":"Feature","place_type":["postcode"],"relevance":1,"properties":{},"text":"100094","place_name":"100094, Haidian Qu, Beijing Shi, China","bbox":[116.178728,40.00409,116.298249,40.124695],"center":[116.25,40.09],"geometry":{"type":"Point","coordinates":[116.25,40.09]},"context":[{"id":"locality.13188648206299350","wikidata":"Q393454","text":"Haidian Qu"},{"id":"place.11643701859936750","wikidata":"Q956","text":"Beijing Shi"},{"id":"country.2656715919","wikidata":"Q148","short_code":"cn","text":"China"}]},{"id":"locality.13188648206299350","type":"Feature","place_type":["locality"],"relevance":1,"properties":{"wikidata":"Q393454"},"text":"Haidian Qu","place_name":"Haidian Qu, Beijing Shi, China","bbox":[116.043457,39.88544,116.388428,40.159663],"center":[116.29214,39.95812],"geometry":{"type":"Point","coordinates":[116.29214,39.95812]},"context":[{"id":"place.11643701859936750","wikidata":"Q956","text":"Beijing Shi"},{"id":"country.2656715919","wikidata":"Q148","short_code":"cn","text":"China"}]},{"id":"place.11643701859936750","type":"Feature","place_type":["place"],"relevance":1,"properties":{"wikidata":"Q956"},"text":"Beijing Shi","place_name":"Beijing Shi, China","bbox":[115.416878,39.442355,117.499558,41.059504],"center":[116.39139,39.905],"geometry":{"type":"Point","coordinates":[116.39139,39.905]},"context":[{"id":"country.2656715919","wikidata":"Q148","short_code":"cn","text":"China"}]},{"id":"country.2656715919","type":"Feature","place_type":["country"],"relevance":1,"properties":{"wikidata":"Q148","short_code":"cn"},"text":"China","place_name":"China","bbox":[73.5013381557857,18.0644613007151,134.773408992719,53.5604329981692],"center":[101.901875103385,35.4867029846329],"geometry":{"type":"Point","coordinates":[101.901875103385,35.4867029846329]}}]
/// attribution : "NOTICE: © 2021 Mapbox and its suppliers. All rights reserved. Use of this data is subject to the Mapbox Terms of Service (https://www.mapbox.com/about/maps/). This response and the information it contains may not be retained. POI(s) provided by Foursquare."

@JsonSerializable()
class LocationPlace {
  String? type;
  List<double>? query;
  List<Features>? features;

  LocationPlace({this.type, this.query, this.features});

  factory LocationPlace.fromJson(dynamic json) => _$LocationPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$LocationPlaceToJson(this);
}

/// id : "poi.94489387011"
/// type : "Feature"
/// place_type : ["poi"]
/// relevance : 1
/// properties : {"foursquare":"4b9483a4f964a520047c34e3","landmark":true,"address":"海淀区","category":"coworking space, office"}
/// text : "联想研发大厦"
/// place_name : "联想研发大厦, 海淀区, Beijing Shi, 100094, China"
/// center : [116.292259,40.052]
/// geometry : {"coordinates":[116.292259,40.052],"type":"Point"}
/// context : [{"id":"postcode.17697725104443630","text":"100094"},{"id":"locality.13188648206299350","wikidata":"Q393454","text":"Haidian Qu"},{"id":"place.11643701859936750","wikidata":"Q956","text":"Beijing Shi"},{"id":"country.2656715919","wikidata":"Q148","short_code":"cn","text":"China"}]

@JsonSerializable()
class Features {
  String? id;
  String? type;

  int? relevance;

  @JsonKey(name: "place_type")
  List<String>? placeType;

  String? text;

  @JsonKey(name: "place_name")
  String? placeName;

  Properties? properties;

  Features({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.text,
    this.placeName,
  });

  factory Features.fromJson(dynamic json) => _$FeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturesToJson(this);
}

/// foursquare : "4b9483a4f964a520047c34e3"
/// landmark : true
/// address : "海淀区"
/// category : "coworking space, office"

@JsonSerializable()
class Properties {
  String? foursquare;
  bool? landmark;
  String? address;
  String? category;

  Properties({this.foursquare, this.landmark, this.address, this.category});

  factory Properties.fromJson(dynamic json) => _$PropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
