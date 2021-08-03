import 'package:centre/src/actuator/user_info_model.dart';
import 'package:common/common.dart';
import 'package:dio/dio.dart';

import '../centre_config.dart';

/**
 * Actuator
 * 登录
 * @author: Ruoyegz
 * @date:
 */
class LoginActuator extends ReactActuator {
  /// 信息
  String phone = "";
  String password = "";
  CountryCode country = CountryCode.create();

  /**
   * 登录
   * "gps":userCountry
   */
  void login(String areaCode, String phone,
      String password, UserInfoStateCallback callback) async {
    FormData requestBody = FormData.fromMap({
      "user_phone_country": areaCode,
      "user_phone": phone,
      "password": password,
    });

    LogDog.d("login: ${requestBody.fields}");

    DioClient().post(
        CentreUrl.signIn, (response) => UserToken.fromJson(response.data),
        body: requestBody, success: (UserToken body) {
      if (body != null && TextHelper.isNotEmpty(body.token)) {
        UserManager().saveToken(body);

        /// 加载用户信息
        UserInfoModel().loadUserInfo(callback);
      } else {
        toast(message: S.of(context).alltip_loading_error);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {});
  }

  @override
  void dispose() {
    super.dispose();
  }
}
