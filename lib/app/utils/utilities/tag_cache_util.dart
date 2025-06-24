class TagCacheUtil {
  factory TagCacheUtil() => _getInstance ??= TagCacheUtil._();
  TagCacheUtil._();

  static TagCacheUtil? _getInstance;
  List<String> cache = [];

  String saveTag(String className) {
    String tag = '${cache.length}-$className';
    cache.add(tag);
    return tag;
  }

  String getTag(String className) {
    String content = cache.where((element) => element.contains(className)).last;
    return content;
  }
}
