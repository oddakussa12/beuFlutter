import 'package:json_annotation/json_annotation.dart';
import 'package:origin/origin.dart';

part 'base_entity.g.dart';

/**
 * user_point.dart
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: false)
class UserPoint {
  double point = 0;
  int comment = 0;
 

  PercentAge? percentage;

  UserPoint(this.point, this.comment,  {this.percentage});

  factory UserPoint.fromJson(dynamic json) => _$UserPointFromJson(json);

  Map<String, dynamic> toJson() => _$UserPointToJson(this);
}

/**
 * PercentAge
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable()
class PercentAge {
  @JsonKey(name: "point_1")
  double point1 = 0;

  @JsonKey(name: "point_2")
  double point2 = 0;

  @JsonKey(name: "point_3")
  double point3 = 0;

  @JsonKey(name: "point_4")
  double point4 = 0;

  @JsonKey(name: "point_5")
  double point5 = 0;

  PercentAge(this.point1, this.point2, this.point3, this.point4, this.point5);

  factory PercentAge.fromJson(dynamic json) => _$PercentAgeFromJson(json);

  Map<String, dynamic> toJson() => _$PercentAgeToJson(this);
}

/**
 * base_entity.dart
 * 图片信息
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: true)
class ImageEntity {
  int height = 0;
  int width = 0;
  String url = "";

  ImageEntity(this.height, this.width, this.url);

  factory ImageEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ImageEntityToJson(this);
}

/**
 * response_body.dart
 * 接口链接
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: true)
class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links(this.first, this.last, this.prev, this.next);

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

/**
 * response_body.dart
 * 接口元数据
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: true)
class Metadata {
  @JsonKey(includeIfNull: true)
  int? to;

  @JsonKey(includeIfNull: true)
  int? from;

  @JsonKey(includeIfNull: true)
  int? total;

  @JsonKey(name: "current_page")
  int? currentPage;

  @JsonKey(name: "last_page")
  int? lastPage;

  @JsonKey(name: "per_page")
  int? perPage;

  @JsonKey(includeIfNull: true)
  String? path;

  Metadata(this.to, this.from, this.total, this.currentPage, this.lastPage,
      this.perPage, this.path);

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

/**
 * base_entity.dart
 * Http 错误
 * @author: Ruoyegz
 * @date: 2021/7/15
 */
@JsonSerializable()
class HttpError {
  String? message;

  HttpError(this.message);

  factory HttpError.fromJson(Map<String, dynamic> json) =>
      _$HttpErrorFromJson(json);

  Map<String, dynamic> toJson() => _$HttpErrorToJson(this);
}

/**
 * 上传文件前的先请求上传参数实体
 */
@JsonSerializable()
class UploadResBody {
  Map<String, String>? form;
  String? action;
  String? domain;

  UploadResBody(this.form, this.action, this.domain);

  factory UploadResBody.fromJson(Map<String, dynamic> json) =>
      _$UploadResBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResBodyToJson(this);
}

/**
 * App 版本信息
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
@JsonSerializable()
class VersionBody {
  VersionInfo data;

  VersionBody(this.data);

  factory VersionBody.fromJson(Map<String, dynamic> json) =>
      _$VersionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VersionBodyToJson(this);
}

/**
 * base_entity.dart
 * App 版本信息
 * @author: Ruoyegz
 * @date: 2021/7/31
 */
@JsonSerializable()
class VersionInfo {
  String platform;
  String version;
  String last;
  String upgrade_point;

  /// 是否需要升级
  bool isUpgrade;

  /// 是否必须升级
  bool mustUpgrade;

  bool? isNone = false;

  factory VersionInfo.none() {
    return VersionInfo("", "", "", "", false, false, isNone: true);
  }

  VersionInfo(this.platform, this.version, this.last, this.upgrade_point,
      this.isUpgrade, this.mustUpgrade,
      {this.isNone = false});

  factory VersionInfo.fromJson(Map<String, dynamic> json) =>
      _$VersionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VersionInfoToJson(this);
}
