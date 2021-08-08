import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/**
 * Loading
 * @author: Ruoyegz
 * @date: 2021/7/10
 */
class LoadingDialog extends StatelessWidget {
  /// 消息
  final String? message;

  final bool? autoDismiss;

  const LoadingDialog({Key? key, this.message, this.autoDismiss = true})
      : super(key: key);

  static void show(BuildContext context,
      {bool? autoDismiss = true, bool? barrierDismiss = false}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismiss!,
        builder: (context) {
          return LoadingDialog(
            autoDismiss: autoDismiss,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 90),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColor.color40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 150,
            alignment: Alignment.center,
            child: ClassicsLoadingWidget(
              indicator: BallSpinFadeLoaderIndicator(),
              size: 48,
              color: AppColor.colorF7551D,
            ),
          ),
        ],
      ),
    );
  }
}
