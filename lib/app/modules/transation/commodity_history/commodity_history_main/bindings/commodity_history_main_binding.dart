import 'package:get/get.dart';

import '../controllers/commodity_history_main_controller.dart';

class CommodityHistoryMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityHistoryMainController>(
      () => CommodityHistoryMainController(),
    );
  }
}
