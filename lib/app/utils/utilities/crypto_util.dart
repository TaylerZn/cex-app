import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:nt_app_flutter/app/network/best_api/best_api.dart';

const secret = 'cexchange@2025';

class CryptoUtil {
  static bikaSign(params) {
    // 对参数进行字典排序
    var sortedKeys = params.keys.toList()..sort();

    // 拼接字符串
    var baseString = StringBuffer();
    for (var key in sortedKeys) {
      if (key == 'sign') continue; // 移除签名字段
      if (key == 'file') continue; // 移除签名字段
      var value = params[key];
      if (value != null) {
        baseString.write('$key$value');
      }
    }
    baseString.write(secret);

    // MD5 加密
    var curSign = md5.convert(utf8.encode(baseString.toString())).toString();

    return curSign;
  }

  static String encryptParams(map) {
    var builder = StringBuffer();
    map.forEach((key, value) {
      builder.write(key);
      builder.write(value);
    });
    builder.write(secret);
    return string2MD5(builder.toString());
  }

  static String string2MD5(String text) {
    var bytes = utf8.encode(text);
    var digest = md5.convert(bytes);
    return digest.toString();
  }

  static String string2SHA256(String text) {
    var bytes = utf8.encode(text);

    /// key环境区分
    String keyValue = apiType == ApiType.prod
        ? 'pk_live_TGS8xl7xPHqPJHLY3UQjKD93f9PMHa7T'
        : 'sk_test_Q8efRKt8dISEnjGCHkpHjSY4Z4amj7B';
    var key = utf8.encode(keyValue);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return base64Encode(digest.bytes);
  }
}

void main() {
  var tar = CryptoUtil.string2SHA256('helloworld');
  print(tar);
}
