import 'package:get/get.dart';

import '../controllers/http_overrides_controller.dart';

class SetHttpOverridesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetHttpOverridesController>(
      () => SetHttpOverridesController(),
    );
  }
}
