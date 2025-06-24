import 'package:get/get.dart';

import '../controllers/withdraw_detail_controller.dart';

class WithdrawDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawDetailController>(
      () => WithdrawDetailController(),
    );
  }
}
