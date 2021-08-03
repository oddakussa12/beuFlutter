import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';

/**
 * Products
 *
 * @author: Ruoyegz
 * @date: 2021/7/23
 */
class ProductsActuator extends RefreshActuator {
  /// 商品列表
  List<Product> products = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    if (products.isEmpty) {
      changeStatusForLoading();
    }

    loadProducts(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    loadProducts(page, type);
  }

  void loadProducts(int page, PullType type) async {
    String url =
        DiscoverUrl.discoveryShops + "?page=${page}&type=product&order=rated";
    DioClient().get(url, (response) => ProductList.fromJson(response.data),
        success: (ProductList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          products.clear();
        }

        products.addAll(body.data);
      }
    }, complete: () {
      emptyStatus = products.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }
}
