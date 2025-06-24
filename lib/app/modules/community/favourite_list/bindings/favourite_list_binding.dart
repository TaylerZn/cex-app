import 'package:get/get.dart';

import '../controllers/favourite_list_controller.dart';

class FavouriteListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteListController>(
      () => FavouriteListController(),
    );
  }
}
