import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:origin/origin.dart';

int MAX_WAIT_TIME = 8 * 1000 * 1000;

int lastTime = 0;
String lastMessage = "";

// 1625365170489582
// 1625365170257001
//          5000000

toast({
  required String message,
}) {
  /// 在一定时间内相同消息不能多次显示
  if (TextHelper.isEqual(message, lastMessage)) {
    int nowTime = DateTime.now().microsecondsSinceEpoch;
    if (nowTime - lastTime < MAX_WAIT_TIME) {
      return;
    }
    lastTime = nowTime;
  }

  lastMessage = message;
  showToast(
    message,
    radius: 60,
    textPadding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    textStyle: TextStyle(fontSize: 16, color: AppColor.white),
    position: ToastPosition.center,
    backgroundColor: AppColor.color80000,
  );
}
