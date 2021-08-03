import 'package:centre/src/centre_config.dart';
import 'package:common/common.dart';

/**
 * FollowShopsActuator
 * 关注的店铺
 * @author: Ruoyegz
 * @date: 2021/7/30
 */
class FollowShopsActuator extends RefreshActuator {
  /// 发现商铺
  List<Shop> shops = [];

  @override
  void dispose() {
    super.dispose();
    shops.clear();
  }

  @override
  void toRetry() {
    super.toRetry();
    if (shops.isEmpty) {
      pullDown();
    }
  }

  @override
  void onRefreshSource(int page, PullType type) {
    loadDiscoveryBusiness(page, type);
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    loadDiscoveryBusiness(page, type);
  }

  /**
   * 加载支持外卖的商铺
   */
  void loadDiscoveryBusiness(int page, PullType type) async {
    if (shops.isEmpty) {
      changeStatusForLoading();
    }

    String url = CentreUrl.followShops + "?page=${page}";
    DioClient().get(url, (response) => FollowShopEntity.fromJson(response.data),
        success: (FollowShopEntity body) {
      if (body != null && body.data != null) {
        if (page <= 1) {
          shops.clear();
        }
        if (body.data != null && !body.data.isEmpty) {
          shops.addAll(body.data);
        }
      }
    }, complete: () {
      emptyStatus = shops.isNotEmpty ? EmptyStatus.Normal : EmptyStatus.Empty;
      notifySetState();
    });
  }
}
