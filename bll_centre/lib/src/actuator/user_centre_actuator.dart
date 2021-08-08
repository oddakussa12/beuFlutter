import 'package:centre/src/centre_config.dart';
import 'package:centre/src/controller/my_orders_controller.dart';
import 'package:common/common.dart';

/**
 * UserCentreActuator
 * 用户中心
 * @author: Ruoyegz
 * @date: 2021/7/27
 */
class UserCentreActuator extends RefreshActuator {
  /// 当前用户信息
  User user = UserManager().getUser();

  /// 我的订单控制器
  MyOrderController controller = MyOrderController();

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);
    controller.appendComplete((type) {
      refreshCompleted(type);
    });
    appendSubscribe(BusClient().subscribe<SignUpEvent>((event) {
      if (event != null) {
        notifySetState(() {
          user = UserManager().getUser();
        });
        controller.refresh();
      }
    }));
    appendSubscribe(BusClient().subscribe<SignInEvent>((event) {
      if (event != null) {
        notifySetState(() {
          user = UserManager().getUser();
        });
        controller.refresh();
      }
    }));

    /// 监听订单创建完成的事件，并刷新数据
    appendSubscribe(BusClient().subscribe<OrderCreatedEvent>((event) {
      if (event != null) {
        controller.refresh();
      }
    }));

    /// 退出登录事件
    appendSubscribe(BusClient().subscribe<LogoutEvent>((event) {
      if (event != null) {
        controller.cleanOrdersByLogout();
        notifySetState(() {
          user = UserManager().getUser();
        });
      }
    }));

    /// 更新用户信息
    appendSubscribe(BusClient().subscribe<UpdateUserEvent>((event) {
      if (event != null) {
        notifySetState(() {
          user = UserManager().getUser();
        });
      }
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void toRetry() {
    super.toRetry();
  }

  @override
  void onRefreshSource(int page, PullType type) {
    updateUserInfo();
    if (controller != null) {
      controller.refresh();
    }
  }

  @override
  void onLoadMoreSource(int page, PullType type) {
    if (controller != null) {
      controller.loadMore();
    }
  }

  updateUserInfo() async {
    loadUserInfo((state) {
      if (state == 1) {
        toast(message: S.of(context).alltip_loading_error);
      }
    });
  }

  /**
   * 加载用户信息
   */
  void loadUserInfo(StateChanged changed) async {
    DioClient().get(
        CentreUrl.userProfile, (response) => UserBody.fromJson(response.data),
        success: (UserBody body) {
      if (body != null && body.data != null) {
        UserManager().saveUser(body.data);
        if (changed != null) {
          changed.call(2);
        }
      } else {
        callUserProfileFail(changed);
      }
    }, fail: (message, error) {
      callUserProfileFail(changed);
    });
  }

  void callUserProfileFail(StateChanged changed) {
    if (changed != null) {
      changed.call(1);
    }
  }
}
