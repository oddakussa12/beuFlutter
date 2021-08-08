import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:origin/origin.dart';

/**
 * AESHelper
 * AES 加解密
 * @author: Ruoyegz
 * @date: 2021/8/6
 */
class AESHelper {

  /// AES 加密
  static String encrypt(String secret, String content) {
    try {
      final key = Key.fromUtf8(secret);
      final cipher = Encrypter(AES(key, mode: AESMode.cbc));
      final result = cipher.encrypt(content, iv: IV.fromUtf8(secret));
      return result.base64;
    } on Error catch (err) {
      LogDog.e("AESHelper, encrypt err: ${err}", err, err.stackTrace);
      return "";
    }
  }

  /// AES 解密
  static dynamic decrypt(String secret, dynamic base64) {
    try {
      final key = Key.fromUtf8(secret);
      final cipher = Encrypter(AES(key, mode: AESMode.cbc));
      return cipher.decrypt64(base64, iv: IV.fromUtf8(secret));
    } on Error catch (err) {
      LogDog.e("AESHelper, encrypt err: ${err}", err, err.stackTrace);
      return null;
    }
  }
}
