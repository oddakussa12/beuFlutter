import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';

/**
 * SpecialDiscoverActuator
 * 特价商品【发现】
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
class SpecialDiscoverActuator extends ReactActuator {
  /// 特价商品
  SpecialProduct special = SpecialProduct(0, "");

  @override
  void dispose() {
    super.dispose();
  }

  /// specialGoods
  void loadSpecialGoods() {
    if (special.count == 0 && TextHelper.isEmpty(special.image)) {
      DioClient().get(DiscoverUrl.specialGoods,
          (response) => SpecialProductBody.fromJson(response.data),
          success: (SpecialProductBody product) {
        if (product != null && product.data != null) {
          special = product.data;
        }
      }, complete: () {
        notifySetState();
      });
    }
  }
}
