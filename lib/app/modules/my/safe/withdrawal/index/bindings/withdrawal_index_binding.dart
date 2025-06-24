import 'package:get/get.dart';
import '../controllers/withdrawal_index_controller.dart';

class MySafeWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeWithdrawalController>(
      () => MySafeWithdrawalController(),
    );
  }
}
