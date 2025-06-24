import 'package:get/get.dart';

import '../controllers/post_index_controller.dart';

class PostIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostIndexController>(() {
      return PostIndexController();
    });
  }
}
