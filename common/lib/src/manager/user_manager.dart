import 'dart:convert';

import 'package:common/src/event/bus_client.dart';

import '../../common.dart';
import '../event/bus_event.dart';

/**
 * user_manager.dart
 * 用户管理器
 * @author: Ruoyegz
 * @date: 2021/7/8
 */
class UserManager {
  /// user token
  static const String USER_TOKEN = "Tuoskener";

  /// user_profile
  static const String USER_PROFILE = "Upsreorfle";
  static const String user_address_name = "user_address_name";
  static const String user_address_phone = "user_address_phone";
  static const String user_address_adress = "user_address_address";

  /// Token 类型
  String _type = "";

  /// Token 值
  String _token = "";

  /// 是否登录
  bool logined = false;

  /// 用户信息
  User _user = User.none();

  /// Token 缓存
  UserToken _userToken = UserToken.none();

  static UserManager _instance = UserManager._init();

  factory UserManager() => _sharedInstance();

  static UserManager _sharedInstance() {
    return _instance;
  }

  UserManager._init() {}

  initManager() async {
    String? tokenJson = await Storage.getString(USER_TOKEN);

    LogDog.d("UserManager.init-token: ${tokenJson}");

    if (TextHelper.isNotEmpty(tokenJson)) {
      UserToken tokenCache = UserToken.fromJson(jsonDecode(tokenJson!));
      if (tokenCache != null && TextHelper.isNotEmpty(tokenCache.token)) {
        _updateToken(tokenCache);
      }
    }

    String? userJson = await Storage.getString(USER_PROFILE);

    LogDog.d("UserManager.init-profile: ${userJson}");

    if (TextHelper.isNotEmpty(userJson)) {
      User userCache = User.fromJson(jsonDecode(userJson!));
      if (userCache != null && TextHelper.isNotEmpty(userCache.id)) {
        _updateUser(userCache);
      }
    }
  }

  bool isLogin() {
    if (!logined) {
      if (TextHelper.isNotEmpty(_token) &&
          _user != null &&
          TextHelper.isNotEmpty(_user.id)) {
        logined = true;
      } else {
        logined = false;
      }
    }
    return logined;
  }

  String getTokenType() {
    if (TextHelper.isEmpty(_type) && _userToken != null) {
      _token = _userToken.token;
      _type = _userToken.type;
    }
    return _type;
  }

  String getToken() {
    if (TextHelper.isEmpty(_token) && _userToken != null) {
      _token = _userToken.token;
      _type = _userToken.type;
    }
    return _token != null ? _token : "";
  }

  User getUser() {
    return _user;
  }

  /**
   * 更新 Token
   */
  void _updateToken(UserToken target) async {
    if (target == null) {
      _type = "";
      _token = "";
      _userToken = UserToken.none();
    } else {
      _userToken = target;
      _type = target.type;
      _token = target.token;
    }
  }

  void saveToken(UserToken target) {
    _updateToken(target);

    /// 缓存用户 token
    Storage.putString(USER_TOKEN, jsonEncode(_userToken));
  }

  void _updateUser(User target) {
    if (target != null) {
      _user = target;
       
      if (TextHelper.isNotEmpty(getToken())) {
        logined = true;
      }
    } else {
      _user = User.none();
      logined = false;
    }
  }

  void saveUser(User target) {
    _updateUser(target);

    /// 缓存用户 token
    Storage.putString(USER_PROFILE, jsonEncode(_user));
  }

  void logout() async {
    _type = "";
    _token = "";
    logined = false;
    _user = User.none();
    _userToken = UserToken.none();

    /// 缓存用户 token
    Storage.putString(USER_TOKEN, jsonEncode(_userToken));

    /// 缓存用户 token
    Storage.putString(USER_PROFILE, jsonEncode(_user));
    Storage.putString(user_address_name, "");
    Storage.putString(user_address_phone, "");
    Storage.putString(user_address_adress, "");
    print("done");

    /// 发送退出登录事件
    BusClient().fire(LogoutEvent());
  }

  /**
   * 对当前用户来说，商品是否可以外卖
   */

  bool delivery(Shop? shop) {
    return /*isLogin() &&*/ shop != null && shop.mayDelivery();
  }
}
