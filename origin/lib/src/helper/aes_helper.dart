import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class AESHelper {
  //aes加密
  static String encrypt(String secret, String content) {
    try {
      final key = Key.fromBase64(base64Encode(secret.codeUnits));
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(content,
          iv: IV.fromBase64(base64Encode(secret.codeUnits)));
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return content;
    }
  }

  //aes解密
  static dynamic decrypt(String secret, dynamic base64) {
    try {
      final key = Key.fromBase64(base64Encode(secret.codeUnits));
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      return encrypter.decrypt64(base64,
          iv: IV.fromBase64(base64Encode(secret.codeUnits)));
    } catch (err) {
      print("aes decode error:$err");
      return base64;
    }
  }
}
