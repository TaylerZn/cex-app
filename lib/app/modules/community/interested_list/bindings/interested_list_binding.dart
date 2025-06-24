import 'package:get/get.dart';

import '../controllers/interested_list_controller.dart';

class InterestedListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterestedListController>(
      () => InterestedListController(),
    );
  }
}
