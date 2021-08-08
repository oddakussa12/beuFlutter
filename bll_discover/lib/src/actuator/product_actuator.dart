import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';
import 'package:discover/src/pages/special_discover_page.dart';

/**
 * Products
 *
 * @author: Ruoyegz
 * @date: 2021/7/23
 */
class ProductsActuator extends RefreshActuator {
  /// 商品列表
  List<Product> products = [];
  late RetrySpecialCallback? callback;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void tapRetry() {
    // TODO: implement tapRetry
    super.tapRetry();
    if (callback != null) {
      callback!.call();
    }
    if (products.isEmpty) {
      pullDown();
    }
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

  loadProducts(int page, PullType type) async {
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
      refreshCompleted(type);
      emptyStatus =
          products.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }
}
