// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPhoneBody _$CheckPhoneBodyFromJson(Map<String, dynamic> json) {
  return CheckPhoneBody(
    json['Signed-in'] as int,
  );
}

Map<String, dynamic> _$CheckPhoneBodyToJson(CheckPhoneBody instance) =>
    <String, dynamic>{
      'Signed-in': instance.state,
    };

CountryCodeBody _$CountryCodeBodyFromJson(Map<String, dynamic> json) {
  return CountryCodeBody(
    (json['data'] as List<dynamic>)
        .map((e) => CountryCode.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CountryCodeBodyToJson(CountryCodeBody instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CountryCode _$CountryCodeFromJson(Map<String, dynamic> json) {
  return CountryCode(
    json['code'] as String,
    json['name'] as String,
    json['areaCode'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$CountryCodeToJson(CountryCode instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'areaCode': instance.areaCode,
      'icon': instance.icon,
    };

UserToken _$UserTokenFromJson(Map<String, dynamic> json) {
  return UserToken(
    json['access_token'] as String,
    json['token_type'] as String,
    json['expires_in'] as int,
  );
}

Map<String, dynamic> _$UserTokenToJson(UserToken instance) => <String, dynamic>{
      'access_token': instance.token,
      'token_type': instance.type,
      'expires_in': instance.expires,
    };

UserBody _$UserBodyFromJson(Map<String, dynamic> json) {
  return UserBody(
    User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserBodyToJson(UserBody instance) => <String, dynamic>{
      'data': instance.data,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
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
    delivery: json['user_delivery'] as bool?,
    userPoint: json['userPoint'] == null
        ? null
        : UserPoint.fromJson(json['userPoint']),
    currency: json['user_currency'] as String?,
    coast: (json['deliveryCoast'] as num?)?.toDouble(),
    subTotal: (json['subTotal'] as num?)?.toDouble(),
    bg: json['user_bg'] as String?,
    avatarLink: json['user_avatar_link'] as String?,
    isChecked: json['isChecked'] as bool?,
  )
    ..friendCount = json['friendCount'] as int?
    ..likedCount = json['likedCount'] as int?
    ..isFriend = json['isFriend'] as bool?
    ..likeState = json['likeState'] as bool?
    ..rank = (json['rank'] as num?)?.toDouble()
    ..score = (json['score'] as num?)?.toDouble()
    ..callCenter = json['callCenter'] as String?;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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
      'friendCount': instance.friendCount,
      'likedCount': instance.likedCount,
      'isFriend': instance.isFriend,
      'likeState': instance.likeState,
      'rank': instance.rank,
      'score': instance.score,
      'callCenter': instance.callCenter,
      'isChecked': instance.isChecked,
    };
