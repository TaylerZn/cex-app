// import 'package:shared_preferences/shared_preferences.dart';
//
// class StorageUtil {
//   static late final SharedPreferences _prefs;
//
//   static Future init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   static String? getData(String key) {
//     return _prefs.getString(key);
//   }
//
//   static Future<bool> setData(String key, String value) {
//     return _prefs.setString(key, value);
//   }
//
//   static bool? getBoolData(String key) {
//     return _prefs.getBool(key);
//   }
//
//   static Future<bool> setBoolData(String key, bool value) {
//     return _prefs.setBool(key, value);
//   }
// }
