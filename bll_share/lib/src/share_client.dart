import 'package:flutter/material.dart';
import 'package:share/src/dialog/share_product_dialog.dart';
import 'package:share/src/dialog/share_shop_dialog.dart';

class ShareClient {

  void showShopLinkDialog(BuildContext context, String share) {
    showDialog(
        context: context,
        builder: (context) {
          return ShareShopDialog();
        });
  }
}
