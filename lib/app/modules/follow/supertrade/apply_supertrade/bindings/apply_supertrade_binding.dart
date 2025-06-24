import 'package:get/get.dart';

import '../controllers/apply_supertrade_controller.dart';

//

class ApplySupertradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplySupertradeController>(
      () => ApplySupertradeController(),
    );
  }
}
