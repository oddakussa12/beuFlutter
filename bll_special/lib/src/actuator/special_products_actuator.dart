import 'package:common/common.dart';

import '../special_config.dart';

/**
 * SpecialProductsActuator
 * 特价商品
 * @author: Ruoyegz
 * @date: 2021/8/4
 */
class SpecialProductsActuator extends RefreshActuator {
  /// 商品列表
  List<SpecProduct> products = [];

  @override
  void dispose() {
    super.dispose();
    products.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    if (products.isEmpty) {
      pullDown();
    }
  }

  @override
  void onRefreshSource(int page, PullType type) {
    loadSpecialProducts(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    loadSpecialProducts(page, type);
  }

  void loadSpecialProducts(int page, PullType type) async {
    if (products.isEmpty) {
      changeStatusForLoading();
    }

    String url = SpecialUrl.specialProducts + "?page=${page}";
    //String url = SpecialUrl.discoveryShops + "?page=${page}&type=product&order=rated";
    DioClient().get(url, (response) => SpecProductList.fromJson(response.data),
        success: (SpecProductList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          products.clear();
        }

        products.addAll(body.data);
      }
    }, complete: () {
      emptyStatus =
          products.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      refreshCompleted(type);
      notifySetState();
    });
  }
}
