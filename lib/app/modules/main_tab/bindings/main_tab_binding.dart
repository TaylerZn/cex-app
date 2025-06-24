import 'package:get/get.dart';

import '../controllers/main_tab_controller.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(
      () => MainTabController(),
    );
  }
}
