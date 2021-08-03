// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceError _$ServiceErrorFromJson(Map<String, dynamic> json) {
  return ServiceError(
    json['message'] as String?,
    (json['errors'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
    ),
  );
}

Map<String, dynamic> _$ServiceErrorToJson(ServiceError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };
