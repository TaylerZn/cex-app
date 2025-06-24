
abstract class CacheInterface {
  Future<Map<String,String>> get(String key);
  Future<void> set(String key, Map<String,String> value);
  Future<void> remove(String key);
  Future<void> clear();
}