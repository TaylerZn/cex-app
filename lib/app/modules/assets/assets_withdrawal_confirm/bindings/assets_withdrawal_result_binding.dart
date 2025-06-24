import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal_confirm/controllers/assets_withdrawal_result_controller.dart';

import '../controllers/assets_withdrawal_confirm_controller.dart';

class AssetsWithdrawalResultBinding extends Bindings {
  @override
  void dependencies() {
    var currency = Get.arguments['currency'];
    var amount = Get.arguments['amount'];
    Get.lazyPut<AssetsWithdrawalResultController>(
      () => AssetsWithdrawalResultController(
        currency: currency,
        amount: amount,
      ),
    );
  }
}
