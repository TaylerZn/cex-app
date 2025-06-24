import 'package:get/get.dart';

import '../controllers/markets_index_controller.dart';

class MarketsIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MarketsIndexController>(
      MarketsIndexController(),
      permanent: true,
    );
  }
}
