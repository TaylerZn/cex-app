import 'package:get/get.dart';

import '../controllers/favourite_topic_controller.dart';

class FavouriteTopicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteTopicController>(
      () => FavouriteTopicController(),
    );
  }
}
