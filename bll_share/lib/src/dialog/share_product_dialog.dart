import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:share/src/actuator/share_shop_actuator.dart';

/**
 * ShareShopDialog
 * 分享商铺弹窗
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ShareProductDialog extends StatefulWidget {
  const ShareProductDialog({Key? key}) : super(key: key);

  @override
  _ShareProductState createState() => _ShareProductState(ShareShopActuator());
}

class _ShareProductState
    extends RetryableState<ShareShopActuator, ShareProductDialog> {
  _ShareProductState(ShareShopActuator actuator) : super(actuator);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
