import 'dart:convert';
import 'package:common/common.dart';
import 'package:dio/dio.dart';

import '../centre_config.dart';

/**
 * CountryCode
 * 国家区号
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class CountryCodeActuator extends RetryActuator {
  /// 国家区号
  List<CountryCode> codes = [];

  /// 过滤的城市 code
  List<String> filterCountry = ["gd", "ms", "dm", "aw", "ht"];

  @override
  void dispose() {
    super.dispose();
    filterCountry.clear();
    codes.clear();
  }

  @override
  void toRetry() {
    if (codes.isEmpty) {
      loadCountryCode();
    }
  }

  /**
   * 加载国家区号
   */
  void loadCountryCode() async {
    String? cache = await Storage.getString(CentreKey.COUNTRY_CODE);
    LogDog.d("loadCountryCode-cache: ${cache}");

    if (TextHelper.isNotEmpty(cache)) {
      CountryCodeBody body = CountryCodeBody.fromJson(json.decode(cache!));
      if (body != null && body.data != null) {
        filterIcon(body.data);

        codes.clear();
        codes.addAll(body.data);

        notifySetState();
        return;
      }
    }

    DioClient().get(CentreUrl.countryCode,
        (response) => CountryCodeBody.fromJson(response.data),
        options: Options(
          sendTimeout: 1000 * 30,
          receiveTimeout: 1000 * 60 * 60 * 24,
          responseType: ResponseType.json,
        ), success: (CountryCodeBody body) {
      if (body != null && body.data != null) {
        filterIcon(body.data);

        codes.clear();
        codes.addAll(body.data);

        Storage.putString(CentreKey.COUNTRY_CODE, json.encode(body));
      }
    }, complete: () {
      notifySetState();
    });
  }

  void filterIcon(List<CountryCode> countries) {
    countries.removeWhere((country) =>
        filterCountry.contains(country.code) && country.icon.endsWith(".svg"));
  }
}
