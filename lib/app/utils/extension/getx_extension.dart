import 'package:get/get.dart';

extension GetxExtension on GetInterface {
  void untilNamed(String routeName) {
    Get.until((route) => Get.currentRoute == routeName);
  }

  /// findOrNull
  T? findOrNull<T>({String? tag}) {
    try {
      if(Get.isRegistered<T>(tag: tag)) {
        return find<T>(tag: tag);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
