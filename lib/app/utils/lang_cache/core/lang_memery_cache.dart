import 'package:nt_app_flutter/app/utils/lang_cache/core/cache_interface.dart';

class LangMemoryCache extends CacheInterface {

  static LangMemoryCache? _instance;

  static LangMemoryCache instance() {
    _instance ??= LangMemoryCache._();
    return _instance!;
  }

  LangMemoryCache._();

  final Map<String, Map<String, String>> _cache = {};

  Map<String, Map<String, String>> get cache => _cache;

  @override
  Future<void> clear() async {
    _cache.clear();
  }

  @override
  Future<Map<String, String>> get(String key) {
    return Future.value(_cache[key] ?? {});
  }

  @override
  Future<void> remove(String key) {
    _cache.remove(key);
    return Future.value();
  }

  @override
  Future<void> set(String key, Map<String, String> value) {
    _cache[key] = value;
    return Future.value();
  }
}
