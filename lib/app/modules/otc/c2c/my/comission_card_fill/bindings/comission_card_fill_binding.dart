import 'package:get/get.dart';

import '../controllers/comission_card_fill_controller.dart';

class ComissionCardFillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComissionCardFillController>(
      () => ComissionCardFillController(),
    );
  }
}
