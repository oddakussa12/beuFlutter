import 'package:common/common.dart';

void main() async {
  /// eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvdGVzdC5hcGkuaGVsbG9vLm1hbnRvdWhlYWx0aC5jb21cL2FwaVwvdXNlclwvcGhvbmVcL3NpZ25JbiIsImlhdCI6MTYyODIyNDEzOSwiZXhwIjoxNjMzNDA4MTM5LCJuYmYiOjE2MjgyMjQxMzksImp0aSI6IldjaFJPUE5ocnJWWjNrZW0iLCJzdWIiOjExNTIyMjYyMzAsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.HmX-8c7UdDcXdrDW2S6gJpSow3Q-Byg_Ex3ru2k7qsw

  /**
   * {
      "delivery_coast": "OadSdXuzL3Klj5jpvqWuBKStDzjUdDA8x9LHLyt9f/mqGxxsuRCP7yVr5PUZF3r5b9eDw0GoWOyidIgfwr4F7ROUrG3lBvemhf/HTr4k24LOmK38Rya9fND51IJm5q29",
      "goods": {
      "b36e5ece-eb5a-11eb-a766-02204a1d8268": 1
      },
      "type": "special"
      }
   */
  String target = """{"1720527578":{"distance":-1.0,"delivery_cost":100.0,"start":[116.2869068,40.0585984],"end":[0.0,0.0]}}""";

  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZXN0LmFwaS5oZWxsb28ubWFudG91aGVhbHRoLmNvbVwvYXBpXC91c2VyXC9waG9uZVwvc2lnbkluIiwiaWF0IjoxNjI4MjM4OTMyLCJleHAiOjE2MzM0MjI5MzIsIm5iZiI6MTYyODIzODkzMiwianRpIjoid3F2cktJU29YeTNuOWhPdSIsInN1YiI6MjQ0LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.-ZlKAL9PykMEXsCHUcOBjTSbmbhv-wnKw6PaY_RiMDc";

  String secret = JWTHelper.decodeForKey(token, "jti");

  String decrypt = "OadSdXuzL3Klj5jpvqWuBKStDzjUdDA8x9LHLyt9f/mqGxxsuRCP7yVr5PUZF3r5b9eDw0GoWOyidIgfwr4F7ROUrG3lBvemhf/HTr4k24LOmK38Rya9fND51IJm5q29";

  LogDog.e("decrypt: ${AESHelper.decrypt(secret, decrypt)}");

}
