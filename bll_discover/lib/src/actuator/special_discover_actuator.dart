import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';

/**
 * SpecialDiscoverActuator
 * 特价商品【发现】
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
class SpecialDiscoverActuator extends ReactActuator {
  // static final int MAX_RETRY_TIME = 60 * 60 * 1000;
  static final int MAX_RETRY_TIME = 60 * 1000;

  /// 特价商品
  SpecialProduct special = SpecialProduct(0, "");

  /// 最近一次请求时间
  int lastRequestTime = 0;

  /// 是否正在请求
  bool isRequesting = false;

  @override
  void dispose() {
    super.dispose();
  }

  void loadSpecialGoods() async {
    if (special.count <= 0) {
      isRequesting = true;
      DioClient().get(DiscoverUrl.specialGoods,
          (response) => SpecialProductBody.fromJson(response.data),
          success: (SpecialProductBody product) {
        if (product != null && product.data != null) {
          special = product.data;
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
