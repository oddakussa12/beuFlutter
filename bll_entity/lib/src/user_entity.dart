import 'package:json_annotation/json_annotation.dart';

import 'base_entity.dart';

part 'user_entity.g.dart';

/**
 * user_entity.dart
 * 检查手机号状态
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
@JsonSerializable()
class CheckPhoneBody {
  @JsonKey(name: "Signed-in")
  int state;

  CheckPhoneBody(this.state);

  factory CheckPhoneBody.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneBodyToJson(this);
}

/**
 * user_entity.dart
 * 国家编号列表
 *
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
@JsonSerializable()
class CountryCodeBody {
  List<CountryCode> data;

  CountryCodeBody(this.data);

  factory CountryCodeBody.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCodeBodyToJson(this);
}

/**
 * user_entity.dart
 *  "code":"et",
    "name":"Ethiopia",
    "areaCode":"251",
    "icon":"et.png"
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
@JsonSerializable()
class CountryCode {
  String code;
  String name;
  String areaCode;
  String icon;

  CountryCode(this.code, this.name, this.areaCode, this.icon);

  factory CountryCode.create() {
    return CountryCode("", "", "00", "");
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCodeToJson(this);

  @override
  String toString() {
    return 'CountryCode{code: $code, name: $name, areaCode: $areaCode, icon: $icon}';
  }
}

/**
 * user_entity.dart
 * 用户 Token
 *
 * access_token : eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVzdC5hcGkuaGVsbG9vLm1hbnRvdWhlYWx0aC5jb21cL2FwaVwvdXNlclwvc2lnblVwIiwiaWF0IjoxNjE4Mjc4MjY5LCJleHAiOjE2MjM0NjIyNjksIm5iZiI6MTYxODI3ODI2OSwianRpIjoieFBzbFJId1FZQ3NPemxWTCIsInN1YiI6MTI4Mjc0MDE4MiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.90XGZvi7u6mw62dOapgjFWd3rnNHqanKVRA_l2wvE_k
 * token_type : bearer
 * expires_in : 5184000
 *
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
@JsonSerializable()
class UserToken {
  @JsonKey(name: "access_token")
  String token;

  @JsonKey(name: "token_type")
  String type;

  @JsonKey(name: "expires_in")
  int expires;

  UserToken(this.token, this.type, this.expires);

  factory UserToken.none() {
    return UserToken("", "", 0);
  }

  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenToJson(this);
}

/**
 * 用户
 *
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
@JsonSerializable()
class UserBody {
  User data;

  UserBody(this.data);

  factory UserBody.fromJson(Map<String, dynamic> json) =>
      _$UserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserBodyToJson(this);
}

/**
 * 用户信息
 *
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
@JsonSerializable()
class User {
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

  @JsonKey(name: "user_address")
  String? address;

  @JsonKey(name: "user_phone")
  String? phone;

  @JsonKey(name: "user_enrollment_at")
  String? enrollmentAt;

  @JsonKey(name: "user_avatar_link")
  String? avatarLink;

  @JsonKey(name: "user_gender")
  int? gender;

  @JsonKey(name: "user_level")
  int? level;

  @JsonKey(name: "user_shop")
  int? shop;

  @JsonKey(name: "user_answer")
  int? answer;

  /// 用户是否激活;1:已激活;0:未激活
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

  int? friendCount;

  int? likedCount;

  bool? isFriend;

  bool? likeState;

  double? rank;

  double? score;

  String? callCenter;

  @JsonKey(ignore: true)
  int? star = 0;

  /// 购物车是否选择该商铺的商品
  bool? isChecked = false;

  User(this.id,
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
      this.delivery = false,
      this.userPoint,
      this.currency,
      this.coast,
      this.subTotal,
      this.bg = "",
      this.avatarLink = "",
      this.star = 0,
      this.isChecked = false});

  factory User.none() {
    return User("", nickName: "");
  }

  int getStar() {
    if (userPoint == null || userPoint!.point <= 0) {
      return 0;
    } else {
      return userPoint!.point.toInt();
    }
  }

  int getComment() {
    if (userPoint == null || userPoint!.comment <= 0) {
      return 0;
    } else {
      return userPoint!.comment;
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
