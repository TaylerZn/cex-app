import 'package:get/get.dart';

import '../controllers/favourite_list_detail_controller.dart';

class FavouriteListDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteListDetailController>(
      () => FavouriteListDetailController(),
    );
  }
}
