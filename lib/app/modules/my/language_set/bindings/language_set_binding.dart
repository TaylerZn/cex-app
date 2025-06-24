import 'package:get/get.dart';

import '../controllers/language_set_controller.dart';

class LanguageSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageSetController(), permanent: true);
  }
}
