import 'package:get/get.dart';

import '../controllers/wallet_history_controller.dart';

class WalletHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletHistoryController>(
      () => WalletHistoryController(),
    );
  }
}
