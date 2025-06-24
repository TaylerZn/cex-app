import 'package:get/get.dart';

import '../controllers/markets_search_controller.dart';

class MarketsSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketsSearchController>(
      () => MarketsSearchController(),
    );
  }
}
