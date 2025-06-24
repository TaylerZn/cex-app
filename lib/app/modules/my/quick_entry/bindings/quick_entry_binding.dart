import 'package:get/get.dart';

import '../controllers/quick_entry_controller.dart';

class QuickEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuickEntryController>(
      () => QuickEntryController(),
    );
  }
}
