import 'package:centre/src/actuator/country_code_actuator.dart';
import 'package:centre/src/items/item_country_code.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * CountryCodePage
 * 国家代码
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class CountryCodePage extends StatefulWidget {
  const CountryCodePage({Key? key}) : super(key: key);

  @override
  _CountryCodePageState createState() =>
      _CountryCodePageState(CountryCodeActuator());
}

class _CountryCodePageState
    extends RetryableState<CountryCodeActuator, CountryCodePage> {
  _CountryCodePageState(CountryCodeActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.loadCountryCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: Toolbar(title: S.of(context).reminder_country),
      body: actuator.isNotNormal()
          ? buildEmptyWidget(context)
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 16),
              itemCount: actuator.codes.isEmpty ? 0 : actuator.codes.length,
              itemBuilder: (context, index) {
                var country = actuator.codes[index];
                return ItemCountryCodeWidget(
                  key: Key("${country.name}-${country.areaCode}"),
                  country: country,
                  onTap: () {
                    Navigator.pop(context, [country]);
                  },
                );
              }),
    );
  }
}
