import 'package:get/get.dart';

import '../controllers/commission_record_controller.dart';

class CommissionRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommissionRecordController>(
      () => CommissionRecordController(),
    );
  }
}
