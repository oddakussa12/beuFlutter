import 'package:centre/src/actuator/user_info_model.dart';
import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';

import '../centre_config.dart';

typedef SuccessCallback = void Function();

/**
 * 1. 注册成功，但没有获取到用户信息
 * 2. 注册成功，获取到了用户信息
 */
typedef RegistedCallback = void Function(int state);

/// 下一步回调
typedef NextStepCallback = void Function();

/**
 * RegisterStepOneActuator
 * 注册第一步：检测手机号
 * @author: Ruoyegz
 * @date:
 */
class RegisterStepOneActuator extends ReactActuator {
  /// 请求标识
  bool isRequesting = false;

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);

    /// 注册成功事件【关闭页面】
    
    appendSubscribe(BusClient().subscribe<SignUpEvent>((event) {
      if (event != null) {
        Navigator.pop(context);
      }
    }));
  }

  /// 注册前检查手机号
  void checkPhone(String code, String phone, NextStepCallback callback) async {
    if (isRequesting) {
      return;
    }

    showLoading();
    isRequesting = true;
    bool successful = false;
    String url = "/api/user/+${code}${phone}/type/phone";
    DioClient().get(url, (response) => CheckPhoneBody.fromJson(response.data),
        success: (CheckPhoneBody body) {
      /// 1. 已注册，0. 未注册
      if (body != null && body.state == 0) {
        successful = true;
      } else {
        toast(message: S.of(context).loginerror_phonerepeat);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      isRequesting = false;
     dismissLoading();

      if (successful != null && successful && callback != null) {
        callback.call();
      }
    });
  }
}

/**
 * RegisterStepTwoActuator
 * 注册第二步
 * @author: Ruoyegz
 * @date:
 */
class RegisterStepTwoActuator extends ReactActuator {
  /// 请求标识
  bool isRequesting = false;

  @override
  void attachViewer(Viewer view) {
    super.attachViewer(view);

    /// 注册成功事件【关闭页面】
    appendSubscribe(BusClient().subscribe<SignUpEvent>((event) {
      if (event != null) {
        Navigator.pop(context);
      }
    }));
  }

  /// 注册前检查用户名
  void checkUserName(String name, NextStepCallback callback) async {
    if (isRequesting) {
      return;
    }

    showLoading();
    isRequesting = true;
    bool successful = false;
    String url = CentreUrl.checkUserName + "?user_name=${name}";
    DioClient().get(url, (response) => response, success: (Response response) {
      if (response != null &&
          response.statusCode! > 200 &&
          response.statusCode! < 300) {
        successful = true;
      } else {
        toast(message: S.of(context).alltip_usernamerule);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      isRequesting = false;
      dismissLoading();
      if (successful != null && successful && callback != null) {
        callback.call();
      }
    });
  }
}

/**
 * RegisterStepThreeActuator
 * 注册第三步：开始注册
 * @author: Ruoyegz
 * @date: 2021/7/26
 */
class RegisterStepThreeActuator extends ReactActuator {
  /// 请求标识
  bool isRequesting = false;

  /// 开始注册
  void startRegister(
      {required String phone,
      required String areaCode,
      required String name,
      required String password,
      required String nickName,
      required UserInfoStateCallback callback}) async {
    if (isRequesting) {
      return;
    }

    showLoading();
    isRequesting = true;

    FormData requestBody = FormData.fromMap({
      "user_phone": phone,
      "user_phone_country": areaCode,
      "password": password,
      "user_name": name,
      "user_nick_name": nickName,
      "registration_type": "user",
    });
    DioClient().post(
        CentreUrl.signUp, (response) => UserToken.fromJson(response.data),
        body: requestBody, success: (UserToken body) {
      if (body != null && TextHelper.isNotEmpty(body.token)) {
        UserManager().saveToken(body);

        /// 加载用户信息
        UserInfoModel().loadUserInfo(callback);
      } else {
        notifyToasty(S.of(context).alltip_loading_error);
      }
    }, fail: (message, error) {
      notifyToasty(message);
    }, complete: () {
      isRequesting = false;
      dismissLoading();
    });
  }
}
