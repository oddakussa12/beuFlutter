import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';

/**
 * shops_actuator.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/23
    // */
class ShopsActuator extends RefreshActuator {
  /// 发现商铺
  List<Shop> shops = [];

  @override
  void dispose() {
    super.dispose();
    shops.clear();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    LogDog.d("ShopsPresenter-onRefreshSource");
    loadDiscoveryBusiness(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    LogDog.d("ShopsPresenter-onLoadMoreSource");
    loadLiveShops(page, type);
  }

  /**
   * 加载支持外卖的商铺
   */
  void loadDiscoveryBusiness(int page, PullType type) async {
    if (shops.isEmpty) {
      changeStatusForLoading();
    }

    String url = DiscoverUrl.discoveryBusiness + "?type=shop&order=popular";
    DioClient()
        .get(url, (response) => DiscoveryShopBody.fromJson(response.data),
            success: (DiscoveryShopBody body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          shops.clear();
        }
        if (body.data.deliveries != null && !body.data.deliveries!.isEmpty) {
          shops.addAll(body.data.deliveries!);
        }
        if (body.data.lives != null && !body.data.lives!.isEmpty) {
          shops.addAll(body.data.lives!);
        }
      }
    }, complete: () {
      emptyStatus = shops.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }

  /**
   * 加载普通商铺
   */
  void loadLiveShops(int page, PullType type) async {
    String url =
        DiscoverUrl.discoveryShops + "?page=${page}&type=shop&order=popular";
    DioClient().get(url, (response) => ShopList.fromJson(response.data),
        success: (ShopList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          shops.clear();
        }
        shops.addAll(body.data);
      }
    }, complete: () {
      emptyStatus = shops.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }
}
