import 'package:convert/convert.dart';
import 'package:dart_sm/dart_sm.dart';
// import 'package:sm_crypto/sm_crypto.dart';
import 'dart:convert';

sm4NetworkSign(token, data) {
  SM4.setKey("$token");
  var keys = data.keys.toList();
  var values = data.values.map((v) => v.toString()).toList();
  // 合并、排序、连接
  String result = ([...keys, ...values]..sort()).join('');
  String ecbEncryptData = SM4.encrypt(result);
  // 将十六进制字符串转换为字节列表
  List<int> bytes = hex.decode(ecbEncryptData);
  // 将字节列表编码为 Base64 字符串
  String base64String = base64.encode(bytes);
  return base64String;
}
