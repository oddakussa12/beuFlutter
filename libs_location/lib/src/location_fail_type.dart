/**
 * location_fail_type.dart
 * 定位失败类型
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
enum LFailType {

  /// 异常，不可知
  None,

  /// 定位服务不可用【需要开启定位服务】
  ServiceUnusable,

  /// 没有授予定位权限
  Denied,

  /// 授权被拒且不再授权【需弹窗提醒或跳转设置开启】
  DeniedForever,
}
