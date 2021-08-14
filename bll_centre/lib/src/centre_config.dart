import 'package:common/common.dart';

/**
 * CentreKey
 * 缓存 key
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class CentreKey {
  //// 国家区号
  static const String COUNTRY_CODE = "CountryCode";

  /// user token
  static const String USER_TOKEN = "Tuoskener";

  /// user_profile
  static const String USER_PROFILE = "Upsreorfle";
}

/**
 * RequestUrl
 *
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class CentreUrl {
  static final String SVG_BASE_URLl = DioClient.DOWNLOAD_BASE_URL;

  /// 国家区号
  static final String countryCode =
      DioClient.DOWNLOAD_BASE_URL + "/country_phone_code.json";

  /// 注册：检查手机号
  static final String checkPhone = "/api/user/{phone}/type/phone";

  /// 注册：检查用户名
  static final String checkUserName = "/api/user/account/verification";

  /// 注册：
  static final String signUp = "/api/user/signUp";

  /// 登录
  static final String signIn = "/api/user/phone/signIn";

  /// 获取用户信息
  static final String userProfile = "/api/user/profile";

  /// 我的订单
  static final String myOrders = "/api/order/myself";

  /// 上传图片前请求链接及表单接口
  static String awsApi(String arg1, String arg2) =>
      "/api/aws/${arg1}/form?file=${arg2}";

  /**
   * 修改用户信息
   */
  static String updateUser = "/api/user/myself";

  /**
   * 修改用户名
   */
  static String updateName = "/api/user/name";

  /// 关注的商铺接口
  static final String followShops = "/api/follow/myself";

  /**
   * 获取版本更新信息
   */
  static final String appVersion = "/api/app/home";
}
