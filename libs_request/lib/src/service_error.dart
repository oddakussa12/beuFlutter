import 'package:json_annotation/json_annotation.dart';

part 'service_error.g.dart';

/**
 * base_entity.dart
 * Http 服务器非 200 时的错误提示信息
 * @author: Ruoyegz
 * @date: 2021/7/15
 */
@JsonSerializable()
class ServiceError {
  /// 消息
  String? message;

  /// 错误
  Map<String, List<String>>? errors;

  ServiceError(this.message, this.errors);

  factory ServiceError.fromJson(Map<String, dynamic> json) =>
      _$ServiceErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceErrorToJson(this);
}
