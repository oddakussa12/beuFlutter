import 'package:common/common.dart';
import 'package:discover/src/discover_config.dart';
import 'package:discover/src/pages/special_discover_page.dart';
import 'package:location/location.dart';

/**
 * shops_actuator.dart
 *
 * @author: Ruoyegz
 * @date: 2021/7/23
    // */
class ShopsActuator extends RefreshActuator {
  /// 发现商铺
  List<Shop> shops = [];
  late RetrySpecialCallback? callback;

  LocationAddress? locAddress;

  LocationClient client = LocationClient();

  void checkLocation({LocationFailure? fail}) async {
    client.checkPermission(
        success: (LocationAddress result) {
          locAddress = result;

          onRefreshSource(0, PullType.Down);
          // notifySetState();
        },
        fail: fail);
  }

  void updateLocation({LocationFailure? fail}) async {
    client.start(
        success: (LocationAddress result) {
          locAddress = result;
          onRefreshSource(0, PullType.Down);
          // notifySetState();
        },
        fail: fail);
  }

  @override
  void dispose() {
    super.dispose();
    shops.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    if (callback != null) {
      callback!.call();
    }
    pullDown();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    loadDiscoveryBusinessNear(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    loadDiscoveryBusinessNear(page, type);
  }

  /**
   * 加载支持外卖的商铺
   */
  loadDiscoveryBusiness(int page, PullType type) async {
    if (shops.isEmpty) {
      changeStatusForLoading();
    }

    String url =
        DiscoverUrl.discoveryIndex + "?page=${page}&type=shop&order=popular";
    DioClient().get(url, (response) => ShopList.fromJson(response.data),
        success: (ShopList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          shops.clear();
        }

        shops.addAll(body.data);
      }
    }, complete: () {
      refreshCompleted(type);
      emptyStatus = shops.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }

  loadAvarageprice(int id) {}

  /** 
  * Load nearest
  */
  loadDiscoveryBusinessNear(int page, PullType type) async {
    if (shops.isEmpty) {
      changeStatusForLoading();
    }
    String url;

    // url = DiscoverUrl.discoveryIndex +
    //     "?page=${page}&type=shop&longtitude=${locAddress?.longitude ?? '0'}" +
    //     "&latitude=${locAddress?.latitude ?? '0'}";
    url = DiscoverUrl.discoveryIndex +
        "?page=${page}&type=shop&longtitude=38.79421&latitude=8.99090";

    print("${locAddress?.latitude} ${locAddress?.longitude}");

    DioClient().get(url, (response) => ShopList.fromJson(response.data),
        success: (ShopList body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          shops.clear();
        }

        shops.addAll(body.data);
      }
    }, complete: () {
      refreshCompleted(type);
      emptyStatus = shops.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    }, fail: (arg, e) {
      LogDog.d(e);
      shops.clear();
    });
  }

  /**
   * 加载普通商铺
   */
  @deprecated
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
