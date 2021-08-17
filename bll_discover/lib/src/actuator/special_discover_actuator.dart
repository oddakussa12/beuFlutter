import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';

/**
 * SpecialDiscoverActuator
 * 特价商品【发现】
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
class SpecialDiscoverActuator extends ReactActuator {
  /// 缓存特价商品的封面
  static final String KEY_CACHE_SPECIAL_COVER = "specialCover";

  /// 最大的重试时间【1小时】
  static final int MAX_RETRY_TIME = 60 * 60 * 1000;

  /// 特价商品
  SpecialProduct special = SpecialProduct(0, "");

  /// 最近一次请求时间
  int lastRequestTime = 0;

  /// 是否正在请求
  bool isRequesting = false;

  @override
  void attachViewer(Viewer view) async {
    super.attachViewer(view);
    _initSpecialCover();
  }

  void _initSpecialCover() async {
    String? cover = await Storage.getString(KEY_CACHE_SPECIAL_COVER);
    if (TextHelper.isNotEmpty(cover) && TextHelper.isEmpty(special.image)) {
      notifySetState(() {
        special.count = 0;
        special.image = cover!;
      });
    }

    loadSpecialGoods();
  }

  /**
   * 加载特价商品
   */
  void loadSpecialGoods() async {
    if (special.count <= 0) {
      isRequesting = true;
      DioClient().get(DiscoverUrl.specialGoods,
          (response) => SpecialProductBody.fromJson(response.data),
          success: (SpecialProductBody product) {
        if (product != null && product.data != null) {
          special = product.data;

          /// 缓存封面
          if (TextHelper.isNotEmpty(special.image)) {
            Storage.putString(KEY_CACHE_SPECIAL_COVER, special.image);
          }

          /// 没有特价商品时记录请求时间，为重试准备
          if (special.count <= 0) {
            lastRequestTime = DateTime.now().millisecondsSinceEpoch;
          }

          LogDog.w("loadSpecialGoods, ${lastRequestTime}");
        }
      }, complete: () {
        isRequesting = false;
        notifySetState();
      });
    }
  }

  //// 检查特价商品状态【不可点击时 1 小时内以上可以重新加载】
  void checkSpecialState() async {
    int time = DateTime.now().millisecondsSinceEpoch;
    LogDog.w("loadSpecialGoods, time: ${time}");
    LogDog.w("loadSpecialGoods, lastRequestTime: ${lastRequestTime}");
    LogDog.w("loadSpecialGoods, MAX_RETRY_TIME: ${MAX_RETRY_TIME}");
    LogDog.w("loadSpecialGoods, x: ${time - lastRequestTime}");

    /// 小于 1 小时时可以重新请求
    if (!isRequesting && MAX_RETRY_TIME <= time - lastRequestTime) {
      loadSpecialGoods();
    }
  }
}
