import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:origin/origin.dart';

/**
 * jwt_helper.dart
 * JWT 解析器
 * @author: Ruoyegz
 * @date: 2021/8/6
 */
class JWTHelper {
  static Map<String, dynamic> decode(String token) {
    try {
      return JwtDecoder.decode(token);
    } on Error catch (e) {
      LogDog.w("JWYHelper, decode: ${e.toString()}", e, e.stackTrace);
      return {};
    }
  }

  static dynamic decodeForKey(String token, String key) {
    Map<String, dynamic> result = decode(token);
    return result[key];
  }

  static DateTime expireDate(String token) {
    return JwtDecoder.getExpirationDate(token);
  }

  static Duration remainingTime(String token) {
    return JwtDecoder.getRemainingTime(token);
  }

  static Duration tokenTime(String token) {
    return JwtDecoder.getTokenTime(token);
  }

  static bool isExpired(String token) {
    return JwtDecoder.isExpired(token);
  }
}
