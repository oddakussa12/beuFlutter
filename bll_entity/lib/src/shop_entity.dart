import 'package:entity/src/base_entity.dart';
import 'package:entity/src/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:origin/origin.dart';

part 'shop_entity.g.dart';

/**
 * FollowShopEntity
 * 关注的商铺
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
@JsonSerializable()
class FollowShopEntity {
  List<Shop> data;

  FollowShopEntity({required this.data});

  factory FollowShopEntity.fromJson(dynamic json) =>
      _$FollowShopEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FollowShopEntityToJson(this);
}

/**
 * discover_shops.dart
 * 发现-推荐商铺列表
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@JsonSerializable(includeIfNull: true)
class DiscoverShopEntity {
  @JsonKey(name: "live_shop")
  List<Shop> liveShops;

  @JsonKey(name: "delivery_shop")
  List<Shop> deliveryShops;

  DiscoverShopEntity({required this.liveShops, required this.deliveryShops});

  factory DiscoverShopEntity.fromJson(dynamic json) =>
      _$DiscoverShopEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoverShopEntityToJson(this);
}

/**
 * shop.dart
 * 购物车
 *
 * @author: Ruoyegz
 * @date: 2021/7/1
 */
@JsonSerializable()
class ShoppingCart {
  /// 以商铺为单位
  List<Shop> data;

  /// 购物车总金额
  @JsonKey(ignore: true)
  double? total = 0.0;

  /// 购物车总金额【格式化后的】
  @JsonKey(ignore: true)
  String? formatTotal = "";

  /// 单位
  @JsonKey(ignore: true)
  String? currency = "";

  /// 购物车有不同的币种
  @JsonKey(ignore: true)
  bool? isDiffCurrency = false;

  /// 派送费
  @JsonKey(ignore: true)
  double? coast = 0.0;

  /// 购物车派送费【格式化后的】
  @JsonKey(ignore: true)
  String? formatCoast = "";

  /// 购物车中商品数量
  @JsonKey(ignore: true)
  int? number = 0;

  ShoppingCart(this.data,
      {this.total,
      this.formatTotal,
      this.currency,
      this.isDiffCurrency,
      this.coast,
      this.formatCoast,
      this.number});

  /// 创建一个空购物车
  static ShoppingCart create() {
    return new ShoppingCart([],
        total: 0.0,
        formatTotal: "",
        currency: "",
        isDiffCurrency: false,
        coast: 0.0,
        formatCoast: "",
        number: 0);
  }

  factory ShoppingCart.fromJson(Map<String, dynamic> json) =>
      _$ShoppingCartFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingCartToJson(this);
}

@JsonSerializable()
class ShopDetail {
  Shop data;

  ShopDetail(this.data);

  factory ShopDetail.fromJson(Map<String, dynamic> json) =>
      _$ShopDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDetailToJson(this);
}

/**
 * shop.dart
 * 商品列表
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: true)
class ShopList {
  @JsonKey(includeIfNull: true)
  Links? links;
  @JsonKey(includeIfNull: true)
  Metadata? meta;

  List<Shop> data;

  ShopList(this.links, this.meta, this.data);

  factory ShopList.fromJson(Map<String, dynamic> json) =>
      _$ShopListFromJson(json);

  Map<String, dynamic> toJson() => _$ShopListToJson(this);
}

/**
 * 商铺发现接口
 *
 * @author: Ruoyegz
 * @date: 2021/7/5
 */
@JsonSerializable()
class DiscoveryShopBody {
  @JsonKey()
  Links? links;
  @JsonKey()
  Metadata? meta;

  DiscoveryShops data;

  DiscoveryShopBody(this.links, this.meta, this.data);

  factory DiscoveryShopBody.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryShopBodyFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryShopBodyToJson(this);
}

/**
 * shop.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/5
 */
@JsonSerializable(includeIfNull: true)
class DiscoveryShops {
  @JsonKey(name: "live_shop")
  List<Shop>? lives;

  @JsonKey(name: "delivery_shop")
  List<Shop>? deliveries;

  DiscoveryShops(this.lives, this.deliveries);

  factory DiscoveryShops.fromJson(Map<String, dynamic> json) =>
      _$DiscoveryShopsFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoveryShopsToJson(this);
}

/**
 * shop.dart
 * 商铺信息
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@JsonSerializable()
class Shop {
  @JsonKey(name: "user_id")
  String id;

  @JsonKey(name: "user_uuid")
  String? uuid;

  @JsonKey(name: "user_name")
  String? name;

  @JsonKey(name: "user_nick_name")
  String? nickName;

  @JsonKey(name: "user_country")
  String? country;

  @JsonKey(name: "user_bg")
  String? bg = "";

  @JsonKey(name: "user_birthday")
  String? birthday;

  @JsonKey(name: "user_about")
  String? about;

  @JsonKey(name: "user_school")
  String? school;

  @JsonKey(name: "user_sl")
  String? sl;

  @JsonKey(name: "user_grade")
  String? grade;

  @JsonKey(name: "user_contact")
  String? contact;

  String? callCenter;

  @JsonKey(name: "user_address")
  String? address;

  @JsonKey(name: "user_enrollment_at")
  String? enrollmentAt;

  @JsonKey(name: "user_avatar_link")
  String? avatarLink;

  @JsonKey(name: "user_gender")
  int? gender;

  /// 当时user_shop为1(商店)时，user_level为0表示普通商铺,user_level为1表示认证商铺
  @JsonKey(name: "user_level")
  int? level;

  @JsonKey(name: "user_shop")
  int? shop;

  @JsonKey(name: "user_answer")
  int? answer;

  @JsonKey(name: "user_activation")
  int? activation;

  @JsonKey(name: "user_delivery")
  bool? delivery = false;

  @JsonKey()
  UserPoint? userPoint;

  @JsonKey(name: "user_currency")
  String? currency;

  @JsonKey(name: "deliveryCoast")
  double? coast;

  double? subTotal;

  List<Product>? goods;

  int? friendCount;

  int? likedCount;

  bool? isFriend;

  bool? likeState;

  bool? followState;

  double? rank;

  double? score;

  @JsonKey(ignore: true)
  int? star = 0;

  /// 购物车是否选择该商铺的商品
  bool? isChecked = false;

  bool mayDelivery() {
    return delivery != null ? delivery! : false;
  }

  Shop(this.id,
      {this.uuid,
      this.name,
      this.nickName,
      this.country,
      this.birthday,
      this.about = "",
      this.school,
      this.sl,
      this.grade,
      this.contact = "",
      this.address = "",
      this.enrollmentAt,
      this.gender,
      this.level,
      this.shop,
      this.answer,
      this.activation,
      this.isFriend = false,
      this.delivery = false,
      this.followState,
      this.userPoint,
      this.currency,
      this.coast,
      this.subTotal,
      this.goods,
      this.bg = "",
      this.avatarLink = "",
      this.star = 0,
      this.callCenter,
      this.isChecked = false});

  factory Shop.create(Shop shop) {
    return Shop(shop.id,
        uuid: shop.uuid,
        name: shop.name,
        country: shop.country,
        bg: shop.bg == null ? "" : shop.bg,
        isFriend: false,
        delivery: shop.delivery,
        currency: shop.currency,
        avatarLink: shop.avatarLink,
        about: shop.about,
        contact: shop.contact,
        address: shop.address,
        userPoint: shop.userPoint);
  }

  bool isNotEmpty() {
    return TextHelper.isNotEmpty(id) && TextHelper.isNotEmpty(name);
  }

  int getShopStar() {
    if (userPoint == null || userPoint!.point <= 0) {
      return 0;
    } else {
      return userPoint!.point.toInt();
    }
  }

  int getShopComment() {
    if (userPoint == null || userPoint!.comment <= 0) {
      return 0;
    } else {
      return userPoint!.comment;
    }
  }

  UserPoint getShopPoint() {
    if (userPoint == null) {
      userPoint = UserPoint(0, 0);
    }
    return userPoint!;
  }

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
