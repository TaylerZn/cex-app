import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/controllers/favorite_quick_entry_controller.dart';

import '../controllers/home_index_controller.dart';

class HomeIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteQuickEntryController(), permanent: true);
    Get.lazyPut<HomeIndexController>(
      () => HomeIndexController(),
    );
  }
}
