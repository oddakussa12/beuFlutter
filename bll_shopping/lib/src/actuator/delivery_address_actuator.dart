import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:shopping/shopping.dart';
import 'package:shopping/src/entity/user_address.dart';

/**
 * DeliveryAddressActuator
 *
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
class DeliveryAddressActuator extends RetryActuator {
  /**
   * 用户派送信息
   */
  String? name;
  String? phone;
  String? address;

  List<String>? shopIds;

  int retryCount = 0;
  LocationAddress? locAddress;

  LocationClient client = LocationClient();

  bool alreadyInit = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void toRetry() {}

  void getSavedUserAddress(context) async {
    String? stored_name =
        await Storage.getString(S.of(context).user_address_name);
    String? stored_phone =
        await Storage.getString(S.of(context).user_address_phone);
    String? stored_address =
        await Storage.getString(S.of(context).user_address_address);
    name = stored_name;
    phone = stored_phone;
    address = stored_address;
  }

  Future<void> init(UserAddress params, BuildContext context) async {
    if (!alreadyInit) {
      alreadyInit = true;
      getSavedUserAddress(context);
      // if (TextHelper.isAllEmpty(user ?? [])) print("empty");
      if (params != null) {
        //    name = params.name;
        // phone = params.phone;
        // address = params.address;
        // shopIds = params.shopIds;
        if (name == "" || phone == "") {
          var user = UserManager().getUser();
          // if (name == "") name = user.nickName;
          if (phone == "") phone = user.phone;
        }
      }
      if (Constants.isTesting) {
        name = "XMT-beU";
        phone = "1314520999";
        address = "太阳系地球村中国北京市";
      }
    }
  }

  void check({LocationFailure? fail}) async {
    client.checkPermission(
        success: (LocationAddress result) {
          locAddress = result;
          address = result.address;
          notifySetState();
        },
        fail: fail);
  }

  void startLocation({LocationFailure? fail}) async {
    client.start(
        success: (LocationAddress result) {
          locAddress = result;
          address = result.address;
          notifySetState();
        },
        fail: fail);
  }

  /**
   * 提交定位信息
   */
  void confirmUserInfo(Success<UserAddress> success,
      {Complete? start, Complete? end}) {
    if (TextHelper.isEmpty(name!) || name!.length < 2 || name!.length > 32) {
      notifyToasty(S.of(context).confirm_name_rule);
      return;
    }

    if (TextHelper.isEmpty(phone!) || phone!.length < 7 || phone!.length > 14) {
      notifyToasty(S.of(context).confirm_phone_rule);
      return;
    }

    if (TextHelper.isEmpty(address!) ||
        address!.length < 10 ||
        address!.length > 100) {
      notifyToasty(S.of(context).confirm_address_rule);
      return;
    }

    if (locAddress == null || shopIds == null || shopIds!.isEmpty) {
      success.call(UserAddress(name: name, phone: phone, address: address));
    } else {
      if (start != null) {
        start.call();
      }
      calcDeliveryCoast(success, start: start, end: end);
    }
  }

  /// 请求定位后的配送费
  void calcDeliveryCoast(Success<UserAddress> success,
      {Actioned? start, Actioned? end}) async {
    List<Map<String, dynamic>> shops = [];
    shopIds!.forEach((id) {
      Map<String, Object> args = {};
      args["shop_id"] = id;
      args["start"] = [locAddress!.longitude, locAddress!.latitude];
      shops.add(args);
    });

    Map<String, List<Map<String, dynamic>>> params = {"location": shops};

    UserAddress result =
        UserAddress(name: name, phone: phone, address: address);
    DioClient().post(ShoppingUrl.calcDeliveryCost,
        (response) => DeliveryCoastBody.fromJson(response.data),
        options: Options(
          headers: {"Content-Type": "application/json; charset=UTF-8"},
        ),
        body: jsonEncode(params), success: (DeliveryCoastBody body) {
      if (body != null && body.data != null && body.data.isNotEmpty) {
        /// {"data":[{"start":{"location":[116.2869045,40.0585996],"name":""},"end":{"location":[0,0],"name":""},"shop_id":"1245541166","distance":-1,"delivery_cost":100,"currency":"USD"}]}
        Map<String, Object> params = {};
        body.data.forEach((item) {
          if (item.shopId != null) {
            Map<String, Object> shopParams = {};
            shopParams["distance"] = item.distance ?? 0;
            shopParams["delivery_cost"] = item.deliveryCost ?? 0;
            if (item.start != null && item.start!.location != null) {
              shopParams["start"] = item.start!.location!;
            }
            if (item.end != null && item.end!.location != null) {
              shopParams["end"] = item.end!.location!;
            }
            params[item.shopId!] = shopParams;
          }
        });

        LogDog.d("calcDeliveryCoast, params: ${params}");

        if (params.isNotEmpty) {
          String content = jsonEncode(params);
          dynamic secret =
              JWTHelper.decodeForKey(UserManager().getToken(), "jti");

          String encrypt = AESHelper.encrypt(secret, content);
          result.deliveryCost = encrypt;

          LogDog.d("calcDeliveryCoast, paramsContent: ${content}");
          LogDog.d("calcDeliveryCoast, paramsSecret: ${secret}");

          LogDog.d("calcDeliveryCoast, paramsEncrypt: ${encrypt}");
          LogDog.d(
              "calcDeliveryCoast, paramsDecrypt: ${AESHelper.decrypt(secret, encrypt)}");
        }
      }
    }, complete: () {
      if (end != null) {
        end.call();
      }

      notifySetState();

      success.call(result);
    });
  }
}
