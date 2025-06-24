import 'package:common_utils/common_utils.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/core/cache_interface.dart';

class LangDiskCache extends CacheInterface {
  static LangDiskCache? _instance;

  static LangDiskCache instance() {
    _instance ??= LangDiskCache._();
    return _instance!;
  }

  LangDiskCache._();

  @override
  Future<void> clear() async {
    StringKV.langMap.clear();
  }

  @override
  Future<Map<String, String>> get(String key) {
    String langMapStr = StringKV.langMap.get() ?? "";
    Map<String, Map<String, String>>? data = JsonUtil.getObj(langMapStr, (v) {
      return Map<String, Map<String, String>>.from(
        v.map(
          (key, value) => MapEntry(
            key,
            Map<String, String>.from(value),
          ),
        ),
      );
    });

    if (data == null) {
      return Future.value({});
    } else {
      Map<String, String> langMap = data[key] ?? {};
      if (langMap.isNotEmpty) {
        langMap =
            langMap.map((k, v) => MapEntry(k, v.replaceAll(r'\\n', r'\n')));
      }
      return Future.value(langMap);
    }
  }

  @override
  Future<void> remove(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> set(String key, Map<String, String> value) {
    throw UnimplementedError();
  }

  Future<void> setAll(Map<String, Map<String, String>> value) {
    StringKV.langMap.set(JsonUtil.encodeObj(value), true);
    return Future.value();
  }
}
