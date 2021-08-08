import 'package:origin/origin.dart';

part 'delivery_coast_entity.g.dart';

/**
 * delivery_coast_entity.dart
 * 外面配送费请求参数
 * @author: Ruoyegz
 * @date: 2021/8/4
 */
@JsonSerializable()
class ReqDeliveryCoastBody {
  final List<DeliveryParam> location;

  ReqDeliveryCoastBody(this.location);

  factory ReqDeliveryCoastBody.fromJson(Map<String, dynamic> json) =>
      _$ReqDeliveryCoastBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReqDeliveryCoastBodyToJson(this);
}

/**
 * 派送费
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
@JsonSerializable()
class DeliveryParam {
  final String shop_id;
  final List<double> start;

  DeliveryParam(this.shop_id, this.start);

  factory DeliveryParam.fromJson(Map<String, dynamic> json) =>
      _$DeliveryParamFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryParamToJson(this);

  @override
  String toString() {
    return "${toJson()}";
  }
}

/// start : {"location":[889316202809372.9,3843035958634248.5,1282498147233044.2,-7728274101097449],"name":"*@O(iF(TrL"}
/// end : {"location":[2382204299128904,-6217585816501904,-5371156606313892,-1815627999776452.2,-8268767742052465],"name":"m^0Q)rNm[B"}
/// shop_id : "220000199004299874"
/// distance : -2350935286383932.5
/// delivery_cost : -4444515574771821
/// currency : "BIRR"

@JsonSerializable()
class DeliveryCoastBody {
  List<DeliveryCoast> data;

  DeliveryCoastBody(this.data);

  factory DeliveryCoastBody.fromJson(Map<String, dynamic> json) =>
      _$DeliveryCoastBodyFromJson(json);
}

@JsonSerializable()
class DeliveryCoast {
  Coordinate? start;
  Coordinate? end;

  @JsonKey(name: "shop_id")
  String? shopId;

  double? distance;

  @JsonKey(name: "delivery_cost")
  double? deliveryCost;

  String? currency;

  DeliveryCoast(
      {this.start,
      this.end,
      this.shopId,
      this.distance,
      this.deliveryCost,
      this.currency});

  factory DeliveryCoast.fromJson(Map<String, dynamic> json) =>
      _$DeliveryCoastFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryCoastToJson(this);
}

/**
 * delivery_coast_entity.dart
 * 坐标
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
@JsonSerializable()
class Coordinate {
  String? name;
  List<double>? location;

  Coordinate({this.location, this.name});

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}
