import 'package:get/get.dart';

import '../controllers/new_user_activity_page_controller.dart';

class NewUserActivityPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewUserActivityPageController>(
      () => NewUserActivityPageController(),
    );
  }
}
