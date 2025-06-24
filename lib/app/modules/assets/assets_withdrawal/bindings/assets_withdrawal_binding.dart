import 'package:get/get.dart';

import '../controllers/assets_withdrawal_controller.dart';

class AssetsWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsWithdrawalController>(
      () => AssetsWithdrawalController(),
    );
  }
}
