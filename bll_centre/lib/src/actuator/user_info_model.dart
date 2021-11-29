import 'package:common/common.dart';

import '../centre_config.dart';

/**
 * 1. 登录 | 注册成功，但没有获取到用户信息
 * 2. 登录 | 注册成功，获取到了用户信息
 */
typedef UserInfoStateCallback = void Function(int state);

/**
 * user_info_model.dart
 * 获取用户信息
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
class UserInfoModel {
  /**
   * 加载用户信息
   */
  void loadUserInfo(UserInfoStateCallback callback,
      {Complete? complete}) async {
    DioClient().get(
        CentreUrl.userProfile, (response) => UserBody.fromJson(response.data),
        success: (UserBody body) {
      if (body != null && body.data != null) {
         
        UserManager().saveUser(body.data);

        if (callback != null) {
          callback.call(2);
        }
      } else {
        callUserProfileFail(callback);
      }
    }, fail: (message, error) {
      callUserProfileFail(callback);
    }, complete: complete);
  }

  void callUserProfileFail(UserInfoStateCallback callback) {
    if (callback != null) {
      callback.call(1);
    }
  }
}
