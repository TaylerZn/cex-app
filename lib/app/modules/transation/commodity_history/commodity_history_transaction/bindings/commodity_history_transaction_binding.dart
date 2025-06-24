import 'package:get/get.dart';

import '../controllers/commodity_history_transaction_controller.dart';

class CommodityHistoryTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityHistoryTransactionController>(
      () => CommodityHistoryTransactionController(),
    );
  }
}
