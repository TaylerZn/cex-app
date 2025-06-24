import 'package:get/get.dart';
import '../controllers/withdrawal_index_controller.dart';

class C2CMySafeWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeC2CWithdrawallController>(
      () => MySafeC2CWithdrawallController(),
    );
  }
}
