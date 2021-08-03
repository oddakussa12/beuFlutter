/**
 * empty_status.dart
 * 空状态
 * @author: Ruoyegz
 * @date: 2021/7/20
 */
enum EmptyStatus {
  /// 正常【不显示 EmptyWidget】
  Normal,

  /// 加载中【显示 loading】
  Loading,

  /// 没有数据【显示没有数据】
  Empty,

  /// 加载出错了【显示错误信息|重试】
  Error
}
