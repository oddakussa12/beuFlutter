import 'package:common/common.dart';
import 'package:flutter/material.dart';

import '../centre_config.dart';

/**
 * item_country_code.dart
 * 国家手机编码
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class ItemCountryCodeWidget extends StatefulWidget {
  /// 国家区号
  final CountryCode country;
  final GestureTapCallback? onTap;

  const ItemCountryCodeWidget({Key? key, required this.country, this.onTap})
      : super(key: key);

  @override
  _ItemCountryCodeWidgetState createState() =>
      _ItemCountryCodeWidgetState(country, onTap);
}

class _ItemCountryCodeWidgetState extends State<ItemCountryCodeWidget> {
  /// 国家区号
  final CountryCode country;
  final GestureTapCallback? onTapCountry;

  _ItemCountryCodeWidgetState(this.country, this.onTapCountry);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 64,
        color: AppColor.colorF8,
        margin: EdgeInsets.only(top: 0.38),
        padding: EdgeInsets.only(left: 16, right: 16, top: 1),
        child: Row(
          children: [
            /// 国旗图标
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: country.icon.endsWith(".svg")
                    ? SvgPicture.network(
                        "${CentreUrl.SVG_BASE_URLl}/${country.icon}",
                        width: 36,
                        height: 36,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fill,
                      )
                    : FadeInImage.assetNetwork(
                        placeholder: "packages/resources/res/images/def_cover_1_1.png",
                        image: "${CentreUrl.SVG_BASE_URLl}/${country.icon}",
                        height: 36,
                        width: 36,
                        fit: BoxFit.fill,
                      )),

            /// 国家
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                TextHelper.clean(country.name),
                maxLines: 1,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )),

            /// 区号
            Container(
              child: Text(
                "+${TextHelper.clean(country.areaCode)}",
                maxLines: 1,
                style: TextStyle(
                  color: AppColor.color37,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTapCountry,
    );
  }
}
