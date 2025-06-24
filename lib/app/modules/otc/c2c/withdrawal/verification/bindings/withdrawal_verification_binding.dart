import 'package:get/get.dart';

import '../controllers/withdrawal_verification_controller.dart';

class MySafeWithdrawalVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySafeWithdrawalVerificationController>(() {
      var type = Get.arguments['type'];
      var verificatioData = Get.arguments['verificatioData'];

      return MySafeWithdrawalVerificationController(
        type: type,
        verificatioData: verificatioData,
      );
    });
  }
}
