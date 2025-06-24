import 'package:get/get.dart';

import '../controllers/assets_withdrawal_confirm_controller.dart';

class AssetsWithdrawalConfirmBinding extends Bindings {
  @override
  void dependencies() {
    var currency = Get.arguments['currency'];
    var amount = Get.arguments['amount'];
    var defaultFee = Get.arguments['defaultFee'];
    var networkValue = Get.arguments['networkValue'];
    var address = Get.arguments['address'];
    Get.lazyPut<AssetsWithdrawalConfirmController>(
      () => AssetsWithdrawalConfirmController(
          currency: currency,
          amount: amount,
          defaultFee: defaultFee,
          networkValue: networkValue,
          address:address),
    );
  }
}
