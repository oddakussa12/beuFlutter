import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:share/src/actuator/share_platform_actuator.dart';

/**
 * share_platform_dialog.dart
 * 分享平台选择对话框
 * @author: Ruoyegz
 */
class SharePlatformDialog extends StatefulWidget {
  /// 分享链接
  final String shareLink;

  const SharePlatformDialog({Key? key, required this.shareLink})
      : super(key: key);

  @override
  _SharePlatformState createState() =>
      _SharePlatformState(SharePlatformActuator());
}

class _SharePlatformState
    extends RetryableState<SharePlatformActuator, SharePlatformDialog> {
  _SharePlatformState(SharePlatformActuator actuator) : super(actuator);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
