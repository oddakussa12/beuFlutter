import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:share/src/actuator/share_shop_actuator.dart';

/**
 * ShareShopDialog
 * 分享商铺弹窗
 * @author: Ruoyegz
 * @date: 2021/7/24
 */
class ShareShopDialog extends StatefulWidget {
  const ShareShopDialog({Key? key}) : super(key: key);

  @override
  _ShareShopDialogState createState() =>
      _ShareShopDialogState(ShareShopActuator());
}

class _ShareShopDialogState
    extends RetryableState<ShareShopActuator, ShareShopDialog> {
  _ShareShopDialogState(ShareShopActuator actuator) : super(actuator);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: PlatformSupport.ios()
            ? EdgeInsets.symmetric(horizontal: 40)
            : EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: PlatformSupport.ios()
              ? MediaQuery.of(context).size.width - 60
              : MediaQuery.of(context).size.width - 40,
          child: Text("分享弹窗"),
        ));
  }
}
