import 'dart:convert';

import 'package:common/common.dart';
import 'package:geolocator/geolocator.dart';

import 'location_address.dart';
import 'location_fail_type.dart';
import 'location_place.dart';

/**
 * 定位失败回调
 * enabled：定位服务不可用
 * type：定位权限被拒
 */
typedef LocationFailure = void Function(LocationClient client, LFailType type);

/**
 * location_client.dart
 * 定位客户端
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
class LocationClient {
  static final MAPBOX_TOKEN =
      "pk.eyJ1Ijoiam9uYXRoYW5iYWtlYndhIiwiYSI6ImNrcTU2aGU5aTB6a3EydnBnM2NkZGx5engifQ.kcfa4CPB2RpDCD-kq7Dd6A";

  /// 重试计数器
  int retryCount = 0;

  /// 最大重试次数
  int maxRetryCount = 3;

  LocationClient({this.maxRetryCount = 3});

  void checkPermission(
      {required Success<LocationAddress> success,
      LocationFailure? fail}) async {
    /// 1. 先检测定位服务是否可用
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      LogDog.w("startLocation, locationServices is not enabled");

      if (fail != null) {
        fail.call(this, LFailType.ServiceUnusable);
      }
      return;
    }

    /// 2. 再检测定位权限
    LocationPermission permission = await Geolocator.checkPermission();

    /// 未得到授权时，先请求用户授权
    if (LocationPermission.denied == permission) {
      if (fail != null) {
        fail.call(this, LFailType.Denied);
      }

      return;
    }

    start(success: success, fail: fail);
  }

  void start(
      {required Success<LocationAddress> success,
      LocationFailure? fail}) async {
    try {
      /// 1. 先检测定位服务是否可用
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        LogDog.w("startLocation, locationServices is not enabled");

        if (fail != null) {
          fail.call(this, LFailType.ServiceUnusable);
        }
        return;
      }

      /// 2. 再检测定位权限
      LocationPermission permission = await Geolocator.checkPermission();

      /// 未得到授权时，先请求用户授权
      if (LocationPermission.denied == permission) {
        permission = await Geolocator.requestPermission();
        if (LocationPermission.denied == permission) {
          LogDog.w("startLocation, locationPermission is denied");

          if (fail != null) {
            fail.call(this, LFailType.Denied);
          }
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        LogDog.w("startLocation, locationPermissions are denied forever");

        if (fail != null) {
          fail.call(this, LFailType.DeniedForever);
        }
        return;
      }

      LogDog.w("startLocation, locationPermission is permission");

      _retryLocation(success);
    } on Exception catch (e) {
      LogDog.w("startLocation, error: ${e.toString()}", e);

      if (fail != null) {
        fail.call(this, LFailType.None);
      }
    }
  }

  void _retryLocation(Success<LocationAddress> success) async {
    if (retryCount < maxRetryCount) {
      LogDog.w(
          "_retryLocation, retryCount: ${retryCount}, maxRetryCount: ${maxRetryCount}");

      var position;
      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true,
            timeLimit: Duration(seconds: 15));
      } on Error catch (e) {
        LogDog.w("_retryLocation, Error: ${e}");
      }
      if (position != null) {
        LogDog.w("startLocation, listen, data: ${jsonEncode(position)}");
        if (position.latitude != 0 && position.longitude != 0) {
          geocodingPlaces(position.longitude, position.latitude, success);
        }
      }
    } else {
      retryCount++;
      _retryLocation(success);
    }
  }

  /// 逆地址编码
  void geocodingPlaces(double longitude, double latitude,
      Success<LocationAddress> success) async {
    LocationAddress address = LocationAddress(longitude, latitude);
    String url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/${longitude},${latitude}.json?access_token=${MAPBOX_TOKEN}";
    DioClient().get(
        url, (response) => LocationPlace.fromJson(jsonDecode(response.data)),
        success: (LocationPlace place) {
      if (place != null &&
          place.features != null &&
          place.features!.isNotEmpty) {
        Features feature = place.features![0];
        if (feature != null) {
          address.street = feature.text;
          address.address = feature.placeName;
        }
      }
    }, complete: () {
      if (success != null) {
        success.call(address);
      }
    });
  }

//// 打开定位设置页
  void openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  /// 打开系统设置页
  void openSettings() {
    Geolocator.openAppSettings();
  }
}
