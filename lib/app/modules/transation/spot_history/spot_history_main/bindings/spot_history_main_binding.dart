import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/current_entrust/controllers/spot_current_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/deal/controllers/spot_deal_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_history/history_entrust/controllers/spot_history_entrust_controller.dart';

import '../controllers/spot_history_main_controller.dart';

class SpotHistoryMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotCurrentEntrustController>(
      () => SpotCurrentEntrustController(),
    );
    Get.lazyPut<SpotDealController>(
      () => SpotDealController(),
    );
    Get.lazyPut<SpotHistoryEntrustController>(
      () => SpotHistoryEntrustController(),
    );
    Get.lazyPut<SpotHistoryMainController>(
      () => SpotHistoryMainController(),
    );
  }
}
